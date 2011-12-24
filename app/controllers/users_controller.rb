class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  
  
  def index
		@title = "All users"
		@users = User.paginate(:page => params[:page], :per_page => 10)
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
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
        flash[:success] = "Successfully updated profile."
        redirect_to edit_user_path
    else
        render :action => 'edit'
    end
  end
    
  
  def edit
    @user = User.find(params[:id])
    @title = t(:edit_profile)
    
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end  
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @assignments = @user.assignments
  end
end

