class Api::V1::EventsController < Api::V1::ApiController

  version 1
  before_action :doorkeeper_authorize!

  def index
  	byebug
	events = Event.all
	expose events, each_serializer: EventSerializer
  end

end