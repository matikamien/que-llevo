class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :surname
  has_many :event_items, serializer: EventItemSerializer

  #Falta devolver los items que tiene asignado ese usuario en el evento. (Si se lo llama desde el serializer de eventos)
  def initialize(object, options={})
    super
    @event_id = options[ :event_id ] 
  end

  def 

  def items
  	event_items = []
  	if !@event_id.nil?
  		event_items = EventItem.where(:event_id => @event_id, :event_user_id => object.id)
  	end 
  	event_items
  end

end
