class BraintreeTransparentRedirectSlice::Application < Merb::Controller
  include Merb::BraintreeTransparentRedirectSlice::CreditCardsHelper 
  controller_for_slice
end
