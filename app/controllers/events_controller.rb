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
    event.add_users params[ :user_ids ],current_user if !params[ :user_ids ].nil?
    event.add_items params[ :item_ids ] if !params[ :item_ids ].nil?
    NotificationService.invite_users_to_event event,params[ :user_ids ],current_user if !params[ :user_ids ].nil?
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
    average = event.get_average
    total = event.get_total
    render_json  :average => average, :total => total
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