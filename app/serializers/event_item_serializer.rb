class EventItemSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :name, :cost, :bought
end
