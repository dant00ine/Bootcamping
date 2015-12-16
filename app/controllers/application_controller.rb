class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

private

    def authenticated?
        redirect_to :root unless logged_in?
    end

    # Confirms an admin user.
    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
        # @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

    def only_bootcamp_owner?
        redirect_to :root if current_user.profile.bootcamp_admin != @bootcamp.id
    end

end
