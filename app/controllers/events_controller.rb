class EventsController < ApplicationController

  before_action :doorkeeper_authorize!
  
  # Devuelve los eventos en los que está el usuario.
  def index
	events = current_user.events
	expose events, each_serializer: EventSerializer
  end
  
  # Devuelve el evento cuyo id fue recibido.
  def show
  	event = Event.find params[ :id ]
  	expose event, serializer: EventSerializer
  end

  def create
  	event = Event.create! event_params
    
    #Pasar a un interactor
    user_ids_as_array = Parser.split params[ :user_ids ]
    user_ids_as_array.each do | user_id |
      user = User.find user_id
      event.users << user
    end
    event.save!

    expose event, serializer: EventSerializer
  end

  private

  	def event_params
      params.permit(:name, :date)
    end

end