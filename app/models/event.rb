class Event < ActiveRecord::Base
	has_many :event_items
	has_many :event_users

	validates :name, :date, presence: :true
end
