class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    begin
      render json: { status: 'online', code: 200 }
    rescue => e
      render json: { status: 'offline', code: 500, message: "Server is offline" }
    end
  end
end 