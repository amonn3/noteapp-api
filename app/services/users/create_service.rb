module Users
  class CreateService < BaseService
    attr_reader :sign_up_params
    attr_accessor :user

    def initialize(sign_up_params:)
      @sign_up_params = sign_up_params
    end

    def call
      initialize_user
      add_error("Email inválido") if invalid_email?
      add_error("Email já está em uso") if email_exists?

      if user.save
        @success = true
        @user = user
        self
      else
        add_error(user.errors.full_messages)
        self
      end
    end

    def success?
      @success || false
    end

    private

    def initialize_user
      @user = User.new(sign_up_params)
    end

    def invalid_email?
      ::EmailValidator.invalid?(user.email, mode: :strict) || user.email.include?('@proton')
    end

    def email_exists?
      User.where(email: user.email).any?
    end
  end
end