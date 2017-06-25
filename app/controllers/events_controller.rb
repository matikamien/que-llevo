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
    event.add_users params[ :user_ids ],current_user.id
    event.add_items params[ :item_ids ]
    expose event, serializer: EventSerializer
  end

  def add_user
    event = Event.find params[ :id ]
    event.add_users params[ :user_ids ],current_user.id
    expose event, serializer: EventSerializer
  end

  def assign_item
    event = Event.find params[ :id ]
    event_item = EventItem.find params[ :event_item_id ]
    if params[ :event_user_id ].nil?
      event_item.event_user_id = nil
      event_item.save!
    else
      event_user = EventUser.find params[ :event_user_id ]
      event_user.event_items << event_item
      event_user.save!
    end
    expose event, serializer: EventSerializer
  end

  def add_item
    event = Event.find params[ :id ]
  end

  def delete_item
    event = Event.find params[ :id ]
    event_item = EventItem.find params[ :event_item_id ]
    event.event_items.delete( event_item )
    event.save!
    expose event, serializer: EventSerializer
  end

  private

  	def event_params
      params.permit(:name, :date)
    end

end