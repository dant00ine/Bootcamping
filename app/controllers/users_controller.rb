class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update, :destroy]
	
	def new
		@user = User.new
	end

	def show
	end

	def edit
		
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			User.create_profile_and_declare(@user) #calls User.Model to create
			redirect_to edit_user_profile_path(@user)
		else
			flash[:danger]  = "Smth wrong "
			render 'new'
		end
	end

	def update
		if @user && @user.authenticate(params[:user][:current_password])
			@user.update(user_params)
			flash[:success] = "#{@user.email} was successfully updated."
			redirect_to @user
		else
			flash[:danger] = "#{@user.email} Something went wrong !"
			render :edit
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