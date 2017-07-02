class EventItemsController < ApplicationController

	before_action :doorkeeper_authorize!

	def buy_item
		event_item = EventItem.find params[ :id ]
		event = Event.find event_item.event_id
		BuyItemService.buy_item params[ :id ],params[ :cost ].to_f,event,params[ :bought ]
		expose event_item, serializer: EventItemSerializer
	end

end
		