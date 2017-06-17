class ApplicationController < RocketPants::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  include ActionController::MimeResponds
  include Devise::Controllers::Helpers
  include Doorkeeper::Rails::Helpers
  
  def current_user
    @current_user ||= User.find doorkeeper_token.resource_owner_id
  end
end
