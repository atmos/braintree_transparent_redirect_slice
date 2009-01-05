require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "CreditCard" do
  before(:all) do
    mount_slice
  end
  describe "#info", :given => 'a user with a credit card in the vault' do
    it "should return all the required information" do
      cc = CreditCard.get(1)
      cc.info.first_name.should == "Quentin"
      cc.info.last_name.should == "Blake"
      cc.info.email.should == "quentin@example.org"
      cc.info.address_1.should == "187 Drive By Blvd"
      cc.info.city.should == "Compton"
      cc.info.state.should == "CA"
      cc.info.postal_code.should == "90220"
      cc.info.country.should == "US"
      cc.info.cc_number.should == "4xxxxxxxxxxx1111"
      cc.info.cc_exp.should == "1010"
    end
  end
  describe "#info with bad input" do
    it "should return empty strings if there's nil input on initialize" do
      CreditCardInfo.new.address_1.should == ''
    end
    it "should return empty strings if there's an empty string on initialize" do
      CreditCardInfo.new('').address_1.should == ''
    end
  end
end
