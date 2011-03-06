class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :detect_iphone_request
  helper_method :current_user
  

  protected
  def detect_iphone_request
    # request.format = :iphone if iphone_request?
    # request.format = :ipad if ipad_request?
  end
  
  def iphone_request?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/iPhone/i]
  end

  def ipad_request?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/iPad/i]
  end


  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
