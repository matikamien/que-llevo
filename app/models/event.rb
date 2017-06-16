class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :event_items

	validates :name, :date, presence: :true
end
