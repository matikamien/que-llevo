require 'fcm'

class NotificationService

	def self.invite_users_to_event event,user_id,current_user
		NotificationService.initialize_fcm
		registration_ids = []
		registration_ids << (User.find user_id).firebase_token
		options = {data: 
										 { 
										 	 notification_code: 1, 
											 event_name: event.name,
									 		 user_name: ( current_user.name + " " + current_user.surname ),
									 		 event_id: event.id
									 	 }
							}
		response = @fcm.send(registration_ids, options)
	end

	def self.assign_item event,actioner_user,item_name,notificated_user,action_as_string
		NotificationService.initialize_fcm
		registration_ids = []
		registration_ids << notificated_user.firebase_token
		options = {data: 
										 { 
										 	 notification_code: 2, 
											 event_name: event.name,
									 		 user_name: ( actioner_user.name + " " + actioner_user.surname ),
									 		 event_id: event.id,
									 		 item_name: item_name,
									 		 action: action_as_string
									 	 }
							}
		response = @fcm.send(registration_ids, options)
	end

	def self.send_recommendation event,recommendation
		NotificationService.initialize_fcm
		registration_ids = []
		registration_ids = (NotificationService.get_token_from_event event)

		options = {data: 
										 { 
										 	 notification_code: 3, 
											 event_name: event.name,
									 		 event_id: event.id,
									 		 item_name_to_buy: recommendation.item_name,
									 		 amount_to_buy: recommendation.amount
									 	 }
							}
		response = @fcm.send(registration_ids, options)
	end

	private

		def self.initialize_fcm
			@fcm = FCM.new("AIzaSyBEzGxJLgXF6ntPv-Oaw38Nd3FWLxzjSzk") if @fcm.nil?
		end

		def self.get_registration_ids user_ids
			tokens = []
			user_ids_as_array = []
	    user_ids_as_array = Parser.split user_ids if !user_ids.nil? 
	    user_ids_as_array.each do | user_id |
	      user = User.find user_id
	      tokens << user.firebase_token
	    end
	    tokens
		end

		def self.get_token_from_event event
			tokens = []
			event.event_users.each do | event_user |
				user = User.find event_user.user_id
				tokens << user.firebase_token
			end			
			tokens
		end

end