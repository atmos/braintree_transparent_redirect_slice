require 'rubygems'
require 'merb-core'
require 'merb-slices'
require 'merb-auth-core'
require 'merb-auth-more'
require 'spec'
require 'pp'
require 'ruby-debug'
require 'dm-core'
require 'dm-validations'

# Add braintree_transparent_redirect_slice.rb to the search path
Merb::Plugins.config[:merb_slices][:auto_register] = true
Merb::Plugins.config[:merb_slices][:search_path]   = File.join(File.dirname(__FILE__), '..', 'lib', 'braintree_transparent_redirect_slice.rb')

# Require braintree_transparent_redirect_slice.rb explicitly so any dependencies are loaded
require Merb::Plugins.config[:merb_slices][:search_path]

require File.expand_path(File.dirname(__FILE__)+'/fixtures/user')
require File.expand_path(File.dirname(__FILE__)+'/spec_helpers/edit_form_helper')
require File.expand_path(File.dirname(__FILE__)+'/spec_helpers/braintree/api_helper')


# Using Merb.root below makes sure that the correct root is set for
# - testing standalone, without being installed as a gem and no host application
# - testing from within the host application; its root will be used
Merb.start_environment(
  :testing => true, 
  :adapter => 'runner', 
  :environment => ENV['MERB_ENV'] || 'test',
  :session_store => 'memory'
)
DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

module Merb
  module Test
    module SliceHelper
      # The absolute path to the current slice
      def current_slice_root
        @current_slice_root ||= File.expand_path(File.join(File.dirname(__FILE__), '..'))
      end

      # Whether the specs are being run from a host application or standalone
      def standalone?
        Merb.root == ::BraintreeTransparentRedirectSlice.root
      end
    end
  end
end

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  config.include(Merb::Test::SliceHelper)
  config.before(:all) do
    DataMapper.auto_migrate! if Merb.orm == :datamapper
    user = User.create(:login => 'quentin', :email => 'quentin@example.com',
                :password => 'lolerskates', :password_confirmation => 'lolerskates')
  end

  def quentin_form_info
    { 'firstname' => 'Quentin', 'lastname' => 'Blake',
      'email' => 'quentin@example.org', 'address1' => '187 Drive By Blvd',
      'city' => 'Compton', 'state' => 'CA', 'country' => 'US', 'zip' => '90220',
      'cvv' => '999', 'ccexp' => '1010', 'ccnumber' => '4111111111111111',
      'customer_vault' => 'add_customer', 'customer_vault_id' => '',
      'redirect' => 'http://example.org/credit_cards/new_response'
    }
  end
end

# You can add your own helpers here
#
Merb::Test.add_helpers do
  def mount_slice
    Merb::Router.prepare do
      slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
      add_slice(BraintreeTransparentRedirectSlice)
    end
  end

  def dismount_slice
    Merb::Router.reset! if standalone?
  end
end

given "an authenticated user" do
  response = request url(:perform_login), :method => "PUT", 
                     :params => { :login => 'quentin', :password => 'lolerskates' }
  response.should redirect_to '/'
end

given "a user with a credit card in the vault" do
  response = request url(:perform_login), :method => "PUT", 
                     :params => { :login => 'quentin', :password => 'lolerskates' }
  response.should redirect_to '/'
  response = request("/credit_cards/new")

  api_response = Braintree::Spec::ApiRequest.new('10.00', nil,
                            quentin_form_info.merge({'type'=>'sale', 'payment'=>'creditcard'}))

  response = request("/credit_cards/new_response", :params => api_response.params)
  response.should redirect_to('/')
end
