class UsersController < ApplicationController

  before_action :doorkeeper_authorize!, except: [ :create ]

	# Devuelve todos los usuarios
  def index
		users = User.where.not(id: current_user.id)
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

  def update_token
    user = User.find! params[ :id ]
    user.update_token params[ :token ]
    expose user, serializer: UserSerializer
  end

  private

  	def user_params
      params.permit(:email, :password, :name, :surname)
    end

end
