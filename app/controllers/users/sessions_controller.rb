class Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :authenticate_user!, only: [:destroy]
  
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    
    render json: { 
      status: {code: 200, message: 'Logged in successfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    
    if signed_out
      render json: {
        status: 200,
        message: "Logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end
