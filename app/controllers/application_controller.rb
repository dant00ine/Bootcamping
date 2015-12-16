class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

	def authenticated?
        redirect_to :root unless logged_in?
    end

    def admin?
        # redirect_to :root if current_user.admin == false #true = (false == false)
        redirect_to :root; flash[:info] = "Its not allowed" unless current_user.admin
    end
end
