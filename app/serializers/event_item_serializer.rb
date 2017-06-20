class EventItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :bought
end
