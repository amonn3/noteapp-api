class JwtDenylist
  include Mongoid::Document
  include Mongoid::Timestamps

  field :jti, type: String  # Armazena o ID único do token
  field :exp, type: Time    # Armazena quando o token expira

  # Garante que não existam JTIs duplicados
  index({ jti: 1 }, { unique: true })

  # Configura limpeza automática de tokens expirados
  index({ exp: 1 }, { expire_after_seconds: 0 })

  # Método requerido pelo Devise-JWT
  def self.jwt_revoked?(payload, user)
    exists?(jti: payload['jti'])
  end

  # Método requerido pelo Devise-JWT
  def self.revoke_jwt(payload, user)
    create!(jti: payload['jti'], exp: Time.at(payload['exp'].to_i))
  end
end