class Users::DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: { message: "Welcome #{current_user.name} you're logged in!" }
  end

  private

  def check_authentication
    unless current_user
      render json: { message: 'You must be logged in to access this resource' }, status: :unauthorized
    end
  end
end
