class SessionsController < ApplicationController
  
  prepend_before_action :require_no_authorization!, only: [:new, :create]

  def new
    redirect_to root_path if user_signed_in?
    @user = User.new
  end

  def create
    authenticator = Authenticator.new(email: session_params[:email], password: session_params[:password])
    if authenticator.valid_authentication?
      render json: { auth_token: authenticator.generate_token, user: authenticator.user.serialized }, status: 200
    else
      render json: { error: 'Wrong login details' }, status: 401
    end
  rescue ArgumentError => e
    render json: { error: 'Must supply email and password' }, status: 401
  end

  def destroy
    #remove token
    render json: {}, status: 200
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end