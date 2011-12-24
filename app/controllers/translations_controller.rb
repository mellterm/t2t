class TranslationsController < ApplicationController
    
    def index
       @repo= Repo.find(params[:repo_id])
       @translations = @repo.translations.find_all{|item| item.source_content.present? || item.target_content.present?}.paginate( :per_page => 50, :page => params[:page], :order => 'name')
    end

    def show
      @repo = Repo.find(params[:repo_id])
      @translation = @repo.translations.find(params[:id])
    end

    def new
      @translation = Translation.new
    end

    def create
      #new translation, from repo page
      @repo = Repo.find(params[:id]) 
      @translation = @repo.translations.new(params[:translation])
   
      
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
      #can only edit 
      @repo = Repo.find(params[:repo_id])
      @translation = @repo.translations.find(params[:id])
    end

    def update
      @repo = Repo.find(params[:repo_id])
      @translation = @repo.translations.find(params[:id])
      if @translation.update_attributes(params[:translation])
        flash[:notice] = t(:successfully_updated_translation)
        redirect_to translation_path(@translation)
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
