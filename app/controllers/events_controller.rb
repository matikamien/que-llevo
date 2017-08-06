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
    event.add_users params[ :user_ids ],current_user
    event.add_items params[ :item_ids ] if !params[ :item_ids ].nil?
    expose event, serializer: EventSerializer
  end

  def update
    event = Event.find params[ :id ]
    event.add_users params[ :user_ids ],current_user if !params[ :user_ids ].nil?
    event.add_items params[ :item_ids ] if !params[ :item_ids ].nil? 
    expose event, serializer: EventSerializer
  end

  def get_average
    event = Event.find params[ :id ]
    expose event, serilizer: EventAverageSerializer
  end

  # También desasigna el item si no manda el parámetro event_user_id
  def assign_item
    event = Event.find params[ :id ]
    event_item = EventItem.find params[ :event_item_id ]
    event.desassign_item event,current_user,event_item if params[ :event_user_id ].nil?
    if !params[ :event_user_id ].nil?
      event_user = EventUser.find params[ :event_user_id ]
      event.assign_item event,current_user,event_user,event_item
    end
    expose event, serializer: EventSerializer
  end

  def delete_items
    event = Event.find params[ :id ]
    event.delete_items params[ :event_item_ids ]
    expose event, serializer: EventSerializer
  end

  private

  	def event_params
      params.permit(:name, :date)
    end

end