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
    user_ids_as_array = []
    user_ids_as_array = Parser.split params[ :user_ids ] if !params[ :user_ids ].nil? 
    user_ids_as_array.each do | user_id |
      create_event_user_and_add_to_event user_id,event
    end
    create_event_user_and_add_to_event current_user.id,event
    event.event_items << (get_default_items event.id)
    event.save!

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

    def get_default_items event_id
      default_items = []
      default_items << (EventItem.create! name:'Coca Cola' , event_id: event_id)
      default_items << (EventItem.create! name:'Fernet' , event_id: event_id)
      default_items << (EventItem.create! name:'Hielos' , event_id: event_id)
      default_items << (EventItem.create! name:'Tira de asado' , event_id: event_id)
      default_items << (EventItem.create! name:'Vacio' , event_id: event_id)
      default_items << (EventItem.create! name:'Chorizo' , event_id: event_id)
      default_items << (EventItem.create! name:'Morcilla' , event_id: event_id)
      default_items << (EventItem.create! name:'Provoleta' , event_id: event_id)
      default_items << (EventItem.create! name:'Agua' , event_id: event_id)
      default_items
    end

    def create_event_user_and_add_to_event user_id,event
      user = User.find user_id
      user.events << event
      event_user = EventUser.create! event_id:event.id , user_id:user_id
      event.event_users << event_user
    end

end