class SessionsController < ApplicationController
  def new
    user = User.authenticate(params[:email], params[:password])
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = t(:invalidlogin_flash)
      render "new"
    end      
  end 
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t(:loggedout_flash)
  end 

end
