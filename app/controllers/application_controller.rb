class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :require_login

  def home

    @neededItems = Item.where(needed: true).order("updated_at DESC")

  end
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protected
  def require_login
    redirect_to session_new_path, :notice => "Please enter your pin" and return unless current_user
  end

end
