class ApplicationController < ActionController::API

  include UserTokenAuthentication
  include Authorization
  
  # before_action :authenticate_user_from_token!
  before_action :authenticate_user!, :parse_search_params

  # private
  
  #   def authenticate_user_from_token!
  #     user = params[:user_email].presence && User.find_by_email(params[:user_email])

  #     # Notice how we use Devise.secure_compare to compare the token
  #     # in the database with the token given in the params, mitigating
  #     # timing attacks.
  #     if user && Devise.secure_compare(user.authentication_token, params[:user_token])
  #       sign_in user, store: false
  #     end
  #   end

  #protect_from_forgery with: :exception

  # def authenticate_request 
  #   @current_user = AuthorizeApiRequest.call(request.headers).result 
  #   render json: { error: 'Not Authorized' }, status: 401 unless @current_user 
  # end

  def heartbeat
    render nothing: true
  end

  def parse_search_params
    params[:search]= JSON.parse(params[:search]) if params[:search].is_a?(String)
  end

  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = '*'
  #   headers['Access-Control-Max-Age'] = "1728000"
  # end

  # def cors_preflight_check
  #   if request.method.to_s.downcase == 'options'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = '*'
  #     headers['Access-Control-Max-Age'] = '1728000'
  #     render :text => '', :content_type => 'text/plain'
  #   end
  # end



end
