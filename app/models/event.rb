class Event < ActiveRecord::Base
	has_many :event_items
	has_many :event_users

	validates :name, :date, presence: :true

	def add_users users,current_user_id
    user_ids_as_array = []
    user_ids_as_array = Parser.split users if !users.nil? 
    user_ids_as_array.each do | user_id |
      create_event_user_and_add_to_event user_id
    end
    create_event_user_and_add_to_event current_user_id
    self.save!
	end

	def add_items items
		item_ids_as_array = []
    item_ids_as_array = Parser.split items if !items.nil? 
    item_ids_as_array.each do | item_id |
      create_event_item_and_add_to_event item_id
    end
    self.save!
	end

	private

		def create_event_user_and_add_to_event user_id
      user = User.find user_id
      if ( !user.events.include? self )
      	user.events << self
	      event_user = EventUser.create! event_id:self.id , user_id:user_id
	      self.event_users << event_user
      end      
    end

    def create_event_item_and_add_to_event item_id
    	item_name = (Item.find item_id).name
    	event_item = EventItem.create! event_id:self.id , name:item_name
    	self.event_items << event_item
    end

end
