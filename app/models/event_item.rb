class EventItem < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_user

  validates :name, presence: :true

  def buy
  	self.bought = true	
  end

  def cancel_buy
  	self.bought = false
  end

end
