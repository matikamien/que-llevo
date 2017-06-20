class EventItem < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_user

  validates :name, presence: :true
end
