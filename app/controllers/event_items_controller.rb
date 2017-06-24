class EventItemsController < ApplicationController

	before_action :doorkeeper_authorize!

	def buy_item
		event_item = EventItem.find params[ :id ]
		event_item.bought = params[ :bought ]
		event_item.cost = params[ :cost ].to_f
		event_item.save!
		expose event_item, serializer: EventItemSerializer
	end

end
