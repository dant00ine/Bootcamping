class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in(@user)
			params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
			flash[:success] = "#{@user.email}, Successfully Logged In"
			
			unless @user.profile.profession_id.nil?
				redirect_back_or (@user)
			else
				redirect_to edit_user_profile_path(@user)
			end
		else
			flash.now[:danger] = "Incorrect User/Password"
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_path
	end

end
