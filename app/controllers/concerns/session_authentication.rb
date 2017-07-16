module SessionAuthentication
  extend ActiveSupport::Concern

  included do

    before_action :cleanup_zombie_session, unless: :session_cleared?

    def require_no_authorization!
      @require_no_authorization = true
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authenticate_user!
      redirect_to new_session_path unless @require_no_authorization || current_user
    end

    def user_signed_in?
      current_user
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session[:user_id] = nil
    end

    private

      def session_cleared?
        user_signed_in? || session[:user_id].nil?
      end

      def cleanup_zombie_session
        return unless User.find_by(id: session[:user_id]).nil?
      end

  end

end