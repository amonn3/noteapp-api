class User
  include Mongoid::Document
  include Mongoid::Timestamps


  ## devise config
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  ## user fields
  field :name, type: String
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :notes, type: Array, default: []

  ## recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  field :sign_in_count, type: Integer, default: 0

  ## validatable
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true

  def self.primary_key
    :_id
  end
end
