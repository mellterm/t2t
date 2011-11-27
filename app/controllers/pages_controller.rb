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
    
    
end
