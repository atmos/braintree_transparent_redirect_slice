class BraintreeTransparentRedirectSlice::Application < Merb::Controller
  before :ensure_authenticated
  include Merb::BraintreeTransparentRedirectSlice::CreditCardsHelper 
  controller_for_slice
end
