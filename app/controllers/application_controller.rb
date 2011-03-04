class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :detect_iphone_request
  helper_method :current_user
  

  protected
  def detect_iphone_request
    request.format = :iphone if iphone_request?
  end
  
  def iphone_request?
    iphone_user_agent?
  end

  def iphone_user_agent?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
  end


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
