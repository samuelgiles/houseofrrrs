class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
  end
  
  def create
    user = User.find_by_pin(params[:pin])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Incorrect Pin"
      render "new"
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out"
  end

end
