class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private
    def require_login
      @url_user_id = params[:user_id].nil? ? params[:id] : params[:user_id]
      redirect_to logout_path(@url_user_id) if(session[:user_id].nil? or (@url_user_id.to_s != session[:user_id].to_s))
    end
end
