class EventUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :event_items
end
