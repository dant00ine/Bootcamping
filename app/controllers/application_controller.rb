class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

private

    # Confirms an admin user.
    def admin_user
      unless current_user.admin?
        flash[:danger]='Its allowed only for admins'
        redirect_to(root_url)
      end
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "You must be logged in to access this section"
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
        # @user = User.friendly.find(params[:id])
        puts "*"*50
        puts @user.inspect
        redirect_to(root_url) unless current_user?(@user)
    end

end
