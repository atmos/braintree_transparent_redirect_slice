class BraintreeTransparentRedirectSlice::Payments < BraintreeTransparentRedirectSlice::Application
  def new(credit_card_id)
    fetch_credit_card(credit_card_id)

    @gateway_request = Braintree::GatewayRequest.new(:amount => '10.00')
    render
  end

  def new_response(credit_card_id)
    @gateway_response = Braintree::GatewayResponse.validate(params)
    if error = @gateway_response.error
      redirect(slice_url(:new_credit_card_payment), :message => {:notice => error})
    else
      redirect(slice_url(:credit_card, credit_card_id), :message => {:notice => 'Successfully charged your Credit Card.'})
    end
  end
end
