class EventUserSerializer < ActiveModel::Serializer
 
  has_one :user, serializer: UserShortSerializer
  has_many :event_items, serializer: EventItemSerializer

end
