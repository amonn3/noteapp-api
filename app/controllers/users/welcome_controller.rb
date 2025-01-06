class Users::WelcomeController < ApplicationController
  before_action :authenticate_user!
  def welcome
    render json: 
    { message: 'Bem-vindo ao NoteApp 🚀',
      user: current_user
    }, status: :ok
  end
end
