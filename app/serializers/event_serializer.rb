class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date
  has_many :event_users, serializer: EventUserSerializer

  def date
  	local_date = 'No tiene fecha asignada por el momento!'
  	local_date = object.date.day.to_s + '/' + object.date.month.to_s + '/' + 
  				 object.date.year.to_s if !object.date.nil?
  	local_date
  end

  def initialize(object, options={})
    super
    options[ :event_id ] = object.id
  end

end
