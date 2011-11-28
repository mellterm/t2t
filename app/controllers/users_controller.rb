class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  
  
  def index
		@title = "All users"
		@users = User.all
	end
  
  
  def new
    @user = User.new
      
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #will redirect to user's profile page once created
      redirect_to root_url, :notice => t(:signedup_flash)
    else
      #go back
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit profile" 
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end  
  
  
end