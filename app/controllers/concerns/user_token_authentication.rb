require Rails.root.join("app","classes","authenticator.rb")

class MissingAuthenticationTokenError < StandardError; end
class InvalidAuthenticationTokenError < StandardError; end
class ExpiredAuthenticationTokenError < StandardError; end

module UserTokenAuthentication
  extend ActiveSupport::Concern

  included do

    rescue_from MissingAuthenticationTokenError, with: :missing_authentication_token_response
    rescue_from InvalidAuthenticationTokenError, with: :invalid_authentication_token_response
    rescue_from ExpiredAuthenticationTokenError, with: :expired_authentication_token_response

    def require_no_authorization!
      @require_no_authorization = true
    end

    def current_user
      @current_user ||= Authenticator.find_user_by_token(authorization_token)    
    rescue InvalidTokenParseError, JWT::DecodeError => e
      nil
    end

    def authenticate_user!
      return if @require_no_authorization
      raise ExpiredAuthenticationTokenError.new("Authentication token has expired") if authentication_token_expired?
      raise InvalidAuthenticationTokenError.new("Invalid token authentication") unless user_signed_in?
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id #todo
    end

    def sign_out
      session[:user_id] = nil #todo
    end

    def authorization_token
      request.authorization.try(:split, ' ').try(:last).presence || ""
    end

    def authentication_token_expired?
      Authenticator.find_user_by_token(authorization_token)
      false
    rescue StandardError => e
      return true if e.is_a?(JWT::ExpiredSignature)
      false
    end

    def missing_authentication_token_response
      render json: { error: "Missing user token authentication" }, status: 401
    end

    def invalid_authentication_token_response
      render json: { error: "Invalid user token authentication" }, status: 401
    end

    def expired_authentication_token_response
      render json: { error: "Expired user token authentication" }, status: 401
    end

  end

end