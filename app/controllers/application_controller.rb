require "application_responder"

class ApplicationController < RocketPants::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  include Devise::Controllers::Helpers
  include Doorkeeper::Rails::Helpers
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  def self.mimes_for_respond_to
    [1]
  end
  
  def current_user
    @current_user ||= User.find doorkeeper_token.resource_owner_id
  end
end
