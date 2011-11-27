class TranslationsController < ApplicationController
    
    def index
       @repo= Repo.find(params[:repo_id])
       @translations = @repo.translations.find_all{|item| item.source_content.present? || item.target_content.present?}
    end

    def show
      @translation = Translation.find(params[:id])
    end

    def new
      @translation = Translation.new
    end

    def create
      #new translation, from repo page 
      @translation = Translation.new(params[:translation])
   
      
      #what is the domain?
      
      #do transaction
    
      if @translation.save
        flash[:notice] = "Successfully created translation."
        redirect_to @repo, :action => show(repo)
      else
        #you can only 2 render one thing - response can be :text, :action, :layout => false is a blank form
        render :action => 'new'
        
      end
    end

    def edit
      @translation = translation.find(params[:id])
    end

    def update
      @translation = translation.find(params[:id])
      if @translation.update_attributes(params[:translation])
        flash[:notice] = "Successfully updated translation."
        redirect_to @translation
      else
        render :action => 'edit'
      end
    end

    def destroy
      @translation = Translation.find(params[:id])
      @translation.destroy
      flash[:notice] = "Successfully destroyed translation."
      redirect_to translations_url
    end
    
    

end  
