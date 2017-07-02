class EventUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname
  has_many :event_items, serializer: EventItemSerializer

  def name
  	(User.find object.user_id).name
  end

  def surname
  	(User.find object.user_id).surname
  end

end
