class InvalidTokenParseError < StandardError; end
class Authenticator

  def initialize(email: nil, password:, username: nil)
    raise ArgumentError.new('Must receive an email or username to authenticate') if email.blank? && username.blank?
    @email    = email
    @password = password
    @username = username
    @authentication = self.class.authentication_method
  end

  def user
    @user ||= User.find_by(email: @email)
  end

  def generate_token
    @authentication.encode(user_id: user.id) if valid_authentication?
  end

  def valid_authentication?
    if user && user.authenticate(@password)
      true
    else
      user.errors.add(:authentication, 'Invalid email or password') if user.present?
      false
    end
  end

  def self.authentication_method
    JsonWebTokenAuthentication
  end

  def self.find_user_by_token(token)
    decoded_token_hash = authentication_method.decode(token).presence || raise(InvalidTokenParseError, "Can't decode authentication for #{token}")
    User.find_by(id: decoded_token_hash[:user_id]).presence || raise(InvalidTokenParseError,"Invalid user token #{token}")
  end

end