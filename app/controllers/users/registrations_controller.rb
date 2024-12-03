class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user!, only: [:create]
  
  # Sobrescreve o método create do Devise
  def create
    # Guard clause para email duplicado
    if User.exists?(email: sign_up_params[:email])
      return render json: {
        message: "Email já está em uso"
      }, status: :ok
    end

    build_resource(sign_up_params)
    resource.save

    if resource.persisted?
      render json: {
        message: 'Conta criada com sucesso.',
        user_data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        message: "Erro ao criar conta: #{resource.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end

  def set_flash_message(key, kind, options = {})
    #faz nada mas é necessário para não quebrar a API
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :name)
  end
end