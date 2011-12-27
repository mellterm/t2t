class ReposController < ApplicationController
  
  def index
    #later restrict by user
     @repos= Repo.find(:all)
     @translations = Repo.find(:all).map &:translations   
  end
  
  
  def show
    @title = I18n.t(:your_repo)
    @repo= Repo.find(params[:id])
    @translation = @repo.translations.new
  end
  
  def new
    @title = "Create a New Repo"
    @repo =  Repo.new
    
  end
  
  def create
    #when we are creating a repo.
    
    end

    def update
      #updating a repo means adding translations
        @repo = Repo.find(params[:id])
        @translation = @repo.translations.build(params[:repo][:translation])
        if @translation.valid?
      			Translation.transaction do
      			  	@translation.save
      					flash[:success] = I18n.t(:created_translation)
      					redirect_to repo_translations_path(@repo)
      			end
      	else	
      			flash[:error] = "Not created"
      	end
      end		
      # if @repo.update_attributes(params[:repo])
      #      redirect_to(@repo, :success => 'Repo was updated.')
      # 
      #     else
      #       render :action => "show" 
      # 
      #     end
  
    # end
  
  
end
