class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  rescue_from SoundCloud::ResponseError, with: :service_unavailable
 
  private
 
  def service_unavailable
    flash[:error] = "Waiting for the server..."
    
    redirect_to homepage_path
  end
end
