class Users::WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def welcome
    render json: { message: 'Bem-vindo ao NoteApp 🚀' }
  end
end
