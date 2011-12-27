class PagesController < ApplicationController

  def welcome
    @title = "Welcome"
  end
  
  def development
    @title = "Development"
  end

  def contact
    @title = "Contact"
  end

  def cv
    @title = "CV"
  end
  
  def report
    @title = "Project Report"
  end  
  
  def dataimport
    @title = "Data Import Page"
  end
    
  def log
    @title = "Log page"    
    end
    
  def translate
      @title = "Translate!"
 
    end  
      
end
