class User
  include DataMapper::Resource

  property :id,     Serial
  property :login,  String
  property :email,  String

  has n, :credit_cards
end
require 'merb-auth-more/mixins/salted_user'
require 'merb-auth-slice-password'
Merb::Authentication.user_class = User
Merb::Authentication.user_class.class_eval{ include Merb::Authentication::Mixins::SaltedUser }
Merb::Authentication.activate!(:default_password_form)

class Merb::Authentication
  def fetch_user(session_user_id)
    Merb::Authentication.user_class.get(session_user_id)
  end

  def store_user(user)
    user.nil? ? user : user.id
  end
end
