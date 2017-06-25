class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :surname, :firebase_token

end
