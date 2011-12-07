class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :loggedin?
  # before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  
  private
  #current_user controller method available to the view
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def loggedin?
      current_user != nil
  end
  
  def current_user?(user)
      user == current_user
    end
  
end