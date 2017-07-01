require 'fcm'

class NotificationService

	def self.invite_users_to_event event,user_id,current_user
		NotificationService.initialize_fcm
		registration_ids = [user_id]
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

end