class Api::V1::ApiController < RocketPants::Base
  version 1

  include Devise::Controllers::Helpers
  include Doorkeeper::Rails::Helpers
  
  def current_user
    @current_user ||= User.find doorkeeper_token.resource_owner_id
  end

end