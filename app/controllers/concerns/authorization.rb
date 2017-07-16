module Authorization
  
  extend ActiveSupport::Concern

  included do

    include Pundit
  
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      def user_not_authorized exception
        policy_name = exception.try(:policy).try(:class).to_s.underscore
        query = exception.try(:query).to_s
        flash[:error] = I18n.t "#{policy_name}.#{query}", scope: "pundit", default: :default
        redirect_to root_path
      end
  end

end