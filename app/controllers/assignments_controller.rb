class AssignmentsController < ApplicationController
  def new
      @title = t(:start_a_new_collaboration)
      @assignment = Assignment.new
  end
  
  def create
    # for each role 
     @roles = params[:assignment]["role_ids"]
     count = 0
     @roles.each do |role|
       @assignment = Assignment.new(:user_id => current_user, :role_id => role)
       if @assignment.save
        count = count+1
       end
     end
    
     if count == @roles.count
       redirect_to user_path(current_user), notice: t(:you_are_now_collaborating_on_this_repo) 
     else
       render :new
     end
   end
end
