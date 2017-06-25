class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :events

  def update_token token
  	self.firebase_token = token
  	self.save!
  end
end
