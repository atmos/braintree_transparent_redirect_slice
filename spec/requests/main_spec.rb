require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe  "" do
  before(:all) do
    mount_slice
  end
  describe "visiting /billing", :given => 'an authenticated user' do
    it "should display the user's billing information" do
      response = request("/billing")
      response.status.should be_successful
      response.should have_selector("a[href='/billing/credit_cards/new']")
    end
  end
end
