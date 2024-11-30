class Users::ProtectedController < ApplicationController
  before_action :authenticate_user!


  def index
    if current_user
      render json: { message: 'Você está autenticado' }
    else
      redirect_to new_user_session_path
    end
  end
end
