class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user!, only: [:create]
  
  # Sobrescreve o método create do Devise
  def create
    build_resource(sign_up_params)
    
    resource.save

    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Conta criada com sucesso.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: { message: "Erro ao criar conta: #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  def set_flash_message(key, kind, options = {})
    #faz nada mas é necessário para não quebrar a API
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :name)
  end
end