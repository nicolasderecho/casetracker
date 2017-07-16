class HomeController < ApplicationController

  prepend_before_action :require_no_authorization!, only: [:index]


  def index
    render :text => '', :content_type => 'text/plain'
  end

end
