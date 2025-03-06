class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def requaire_user 
    if !helpers.logged_in?
      flash[:alert] = 'you must be logged in to perform that action'
      redirect_to login_path
    end
  end  
end
