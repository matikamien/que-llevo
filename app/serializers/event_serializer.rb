class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date
  has_many :users

  def date
  	local_date = 'No tiene fecha asignada por el momento!'
  	local_date = object.date.day.to_s + '/' + object.date.month.to_s + '/' + 
  				 object.date.year.to_s if !object.date.nil?
  	local_date
  end

end
