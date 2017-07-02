class EventUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :event_items

  def calculate_spent_money
  	spent_money = 0
  	self.event_items.each do | event_item |
  		spent_money += event_item.cost
  	end	
  	spent_money
  end

end
