module Merb
  module BraintreeTransparentRedirectSlice
    module CreditCardsHelper
      def fetch_credit_card(id)
        @credit_card = CreditCard.get(id)
        raise Merb::ControllerExceptions::NotFound if @credit_card.nil?
        raise Merb::ControllerExceptions::Unauthorized unless @credit_card.user_id == session.user.id
      end

      def braintree_date_reformatter(str)
        DateTime.parse(str).strftime('%Y/%m/%d %H:%M:%S')
      end
    end
  end
end # Merb
