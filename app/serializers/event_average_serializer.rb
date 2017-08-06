class EventAverageSerializer < ActiveModel::Serializer
  attributes :id, :average, :total

  def average
  	object.get_average
  end

  def total
  	object.get_total
  end
end
