module Merb
  module BraintreeTransparentRedirectSlice
    module CreditCardsHelper
      def fetch_credit_card(id)
        @credit_card = CreditCard.get(id)
        raise Merb::ControllerExceptions::NotFound if @credit_card.nil?
        raise Merb::ControllerExceptions::Unauthorized unless @credit_card.user_id == session.user.id
      end
    end
  end
end # Merb
