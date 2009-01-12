require 'digest/md5'

module Braintree
  class GatewayResponse
    def self.validate(params)
      new(params).validate
    end

    def initialize(params)
      @time, @hash, @amount = params.values_at(:time, :hash, :amount)
      @transaction_id, @order_id, @customer_vault_id = params.values_at(:transactionid, :orderid, :customer_vault_id)
      @response, @response_text = params.values_at(:response, :responsetext)
      @avs_response, @cvv_response = params.values_at(:avsresponse, :cvvresponse)
    end

    attr_reader :time, :hash, :amount, :error,
      :transaction_id, :order_id, :customer_vault_id,
      :response, :response_text,
      :avs_response, :cvv_response
#    :authcode
#    :username
#    :type
#    :response_code
#    :full_response

    def validate
      raise Merb::ControllerExceptions::Unauthorized, "Hashes did not match" unless matching_hash?
      if approved?
        if cvv_matches?
          true
        else
          @error = cvv_response_message
        end
      else
        @error = response_text
      end
      self
    end

    # The hash sent with the Gateway Response should equal a hash that can get
    # generated using the key and the sent parameters.
    def matching_hash?
      hash == generated_hash
    end

    # Takes the values of the Gateway Response and generates a hash from them using
    # MD5 and format listed in the documentation.
    def generated_hash
      items = [order_id, amount, response]
      items += [transaction_id, avs_response, cvv_response]
      items << customer_vault_id if customer_vault_id
      items += [time, BraintreeTransparentRedirectSlice.config[:key]]
      Digest::MD5.hexdigest(items.join('|'))
    end

    def approved?
      response == "1"
    end

    # AVS_RESPONSE_CODES
    def avs_matches?
      avs_response.include?("Y")
    end

    # CVV_RESPONSE_CODES
    def cvv_matches?
      cvv_response == "M"
    end

    # A string representation of the response status given as a number.
    def response_message
      case response
      when "1"
        "Approved"
      when "2"
        "Declined"
      when "3"
        "Error"
      else
        raise "Unknown response: #{response.inspect}"
      end
    end

    def cvv_response_message
      case cvv_response
      when "M"
        "CVV2/CVC2 Match"
      when "N"
        "CVV2/CVC2 No Match"
      when "P"
        "Not Processed"
      when "S"
        "Merchant has indicated the CVV2/CVC2 is not present on card"
      when "U"
        "Issuer is not certified and/or has not provided Visa encryption keys"
      else
        #raise "Unknown CVV response: #{cvv_response.inspect}"
      end
    end
  end
end
