class User < ApplicationRecord
  has_secure_password

  has_many :cases
  has_many :comments

  #mount_uploader :avatar, ImageUploader

  validates :email, presence: true, uniqueness: true, email: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :first_name, :last_name, presence: true
  #before_save :ensure_authentication_token
  
  def full_name
    [first_name, last_name].join(" ").strip
  end

  def to_s
    full_name
  end

  def serialized
    UserSerializer.new(self).as_json    
  end

  # private

  #   def ensure_authentication_token
  #     self.authentication_token = generate_authentication_token if authentication_token.blank?
  #     true
  #   end
    
  #   def generate_authentication_token
  #     loop do
  #       token = Devise.friendly_token
  #       break token unless User.where(authentication_token: token).exists?
  #     end
  #   end

end
