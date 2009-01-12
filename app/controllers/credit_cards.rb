class BraintreeTransparentRedirectSlice::CreditCards < BraintreeTransparentRedirectSlice::Application
  def index
    render
  end

  def new
    @credit_card = CreditCard.new
    @credit_card_info = @credit_card.info

    unless message[:transaction_id].nil?
      @credit_card_info = Braintree::TransactionInfo.new(message[:transaction_id])
    end

    @gateway_request = Braintree::GatewayRequest.new(:orderid => Digest::SHA1.hexdigest(Time.now.to_s))
    render
  end

  def new_response
    @gateway_response = Braintree::GatewayResponse.validate(params)
    if error = @gateway_response.error
      redirect(slice_url(:new_credit_card), :message => {:notice => error, :transaction_id => params[:transactionid]})
    else
      session.user.credit_cards.create(:token => @gateway_response.customer_vault_id)
      redirect(slice_url(:credit_cards), :message => {:notice => 'Successfully stored your card info securely.'})
    end
  end

  def edit(id)
    fetch_credit_card(id)
    @credit_card_info = @credit_card.info
    @gateway_request = Braintree::GatewayRequest.new
    render
  end

  def edit_response(id)
    @gateway_response = Braintree::GatewayResponse.validate(params)
    if error = @gateway_response.error
      redirect(slice_url(:edit_credit_card, id), :message => {:notice => error})
    else
      redirect(slice_url(:credit_cards), :message => {:notice => 'Successfully updated your info in the vault.'})
    end
  end

  def show(id)
    fetch_credit_card(id)
    render
  end

  def destroy(id)
    fetch_credit_card(id)
    @gateway_request = Braintree::GatewayRequest.new
    render
  end
end
