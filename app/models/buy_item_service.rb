class BuyItemService

	def self.buy_item event_item_id,cost,event,bought
		event_item = EventItem.find event_item_id
		event_item.bought = bought
		event_item.cost = cost
		event_item.save!
		has_pending_items = event.check_pending_items
		if !has_pending_items
			recommendations = RecommendationService.check_for_recommendations event
			if recommendations.size > 0
				recommendations.each do | recommendation |
					NotificationService.send_recommendation event,recommendation
				end
			end
		end
	end

end
