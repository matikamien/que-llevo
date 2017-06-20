class UsersController < ApplicationController

	# Devuelve todos los usuarios
  def index
		users = User.all
		expose users, each_serializer: UserSerializer
  end

  # Crea un usuario con los parámetros obtenidos
  def create
  	user = User.create! user_params
    expose user, serializer: UserSerializer
  end

  # Devuelve el usuario cuyo id fue recibido.
  def show
  	user = User.find! params[ :user_id ]
    expose user, serializer: UserSerializer
  end

  private

  	def user_params
      params.permit(:email, :password, :name, :surname)
    end

end