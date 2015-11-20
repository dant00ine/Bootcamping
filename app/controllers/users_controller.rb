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
			flash[:success] = "#{@user.email} Successfully Signed Up"
			redirect_to :back
		else
			flash[:danger]  = "Smth wrong "
			render 'new'
		end
	end

	def destroy
	end

private

	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end