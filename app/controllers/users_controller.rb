class UsersController < ApplicationController
  def login
  end

  def logout
  end

  def options
  end

  def changepin

  	newpin = params[:user][:pin]

  	if !User.find_by_pin(newpin) && newpin.length == 4

  		current_user.pin = params[:user][:pin]
  		current_user.save
  		flash.notice = "Pin Changed Successfully"

  	else

  		flash.notice = "Invalid Pin"

  	end

  	redirect_to action: 'options'

  end
end
