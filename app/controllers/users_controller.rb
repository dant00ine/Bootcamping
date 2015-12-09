class UsersController < ApplicationController
	before_action :set_user, only: [:show, :destroy]
	
	def new
		@user = User.new
	end

	def show
		
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			@user.create_profile(id: @user.id, user_id: @user.id, contact_email: @user.email)
			redirect_to edit_user_profile_path(@user)
		else
			flash[:danger]  = "Smth wrong "
			render 'new'
		end
	end

	def destroy
    	@user.destroy
		log_out if logged_in?
		flash[:danger] = 'Sad to see, You leaving us.'
    	redirect_to :root
  	end

private

	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end