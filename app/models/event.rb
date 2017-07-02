class Event < ActiveRecord::Base
	has_many :event_items
	has_many :event_users

	validates :name, :date, presence: :true

  DESASSIGN = "desasignó"
  ASSIGN = "asignó"

	def add_users users,current_user
    user_ids_as_array = []
    user_ids_as_array = Parser.split users if !users.nil? 
    user_ids_as_array.each do | user_id |
      create_event_user_and_add_to_event user_id,current_user
    end
    create_event_user_and_add_to_event current_user.id,current_user
	end

	def add_items items
		item_ids_as_array = []
    item_ids_as_array = Parser.split items if !items.nil? 
    item_ids_as_array.each do | item_id |
      create_event_item_and_add_to_event item_id
    end
	end

  def get_total
    total = 0
    self.event_users.each do | user |
      total += user.calculate_spent_money
    end
    total
  end

  def get_average
    ( get_total / self.event_users.count )
  end

  def delete_items item_ids
    item_ids_as_array = []
    item_ids_as_array = Parser.split item_ids if !item_ids.nil? 
    item_ids_as_array.each do | item_id |
      event_item = EventItem.find item_id
      self.event_items.delete( event_item )
      self.save!
    end
  end

  def assign_item event,actioner_user,event_user,event_item
    if !event_item.event_user_id.nil?
      previous_event_user = EventUser.find event_item.event_user_id
      previous_user = User.find previous_event_user.user_id
      NotificationService.assign_item event,actioner_user,event_item.name,previous_user,DESASSIGN
    end
    event_user.event_items << event_item
    user = User.find event_user.user_id
    NotificationService.assign_item event,actioner_user,event_item.name,user,ASSIGN
    event_user.save!
  end

  def desassign_item event,actioner_user,event_item
    event_user = EventUser.find event_item.event_user_id
    user = User.find event_user.user_id
    event_item.event_user_id = nil
    NotificationService.assign_item event,actioner_user,event_item.name,user,DESASSIGN
    event_item.save!    
  end

	private

		def create_event_user_and_add_to_event user_id,current_user
      user = User.find user_id
      if ( !user.events.include? self )
      	user.events << self
	      event_user = EventUser.create! event_id:self.id , user_id:user_id , spent_money:0
	      self.event_users << event_user
        NotificationService.invite_users_to_event self,user_id,current_user if (user != current_user)
      end
      self.save!      
    end

    def create_event_item_and_add_to_event item_id
    	item_name = (Item.find item_id).name
    	event_item = EventItem.create! event_id:self.id , name:item_name
    	self.event_items << event_item
    	self.save!
    end

end
