class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user!, only: [:create]
  
  # Sobrescreve o método create do Devise
  def create
    create_service = Users::CreateService.new(sign_up_params: sign_up_params).call

    if params_nil?
      return render json: {
        message: "Todos os campos são obrigatórios"
      }, status: :unprocessable_entity
    end

    if create_service.success?
      render json: {
        message: "Conta criada com sucesso",
        user_data: create_service.user
      }, status: :created
    else
      render json: {
        message: "#{create_service.instance_variable_get("@error").first.to_s}"
      }, status: :unprocessable_entity
    end
  end

  def set_flash_message(key, kind, options = {})
    #faz nada mas é necessário para não quebrar a API
  end

  protected

  def params_nil?
    (params[:user][:name].nil? || params[:user][:password].nil? || params[:user][:email].nil? )
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :name)
  end
end