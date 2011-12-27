class SourceDocsController < ReposController 
  
  
  def new
    @sourcedoc = SourceDoc.new
    @sourcedoc.domains.build
  end 
  
  def create
    @sourcedoc = SourceDoc.new(params[:source_doc])
    @domain = Domain.find_by_id(params[:source_doc][:domain][:name])
    @repodomain = RepoDomain.new(:repo_id => @sourcedoc, :domain_id => @domain)
    if @sourcedoc.save && @repodomain.save
          flash[:notice] = t(:success)
          redirect_to root
        else
          render :action => 'new'
        end
    
  end
  
end