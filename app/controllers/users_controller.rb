class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update, :destroy]
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]
	# before_action :admin_user,     only: :destroy
	
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		# if @user.errors.size == 1 and @user.errors.keys[0] == :nick_name
		if @user.save
			log_in(@user)
			User.create_profile_and_declare(@user) #calls User.Model to create Profile under the same ID of User!
			redirect_to edit_user_profile_path(@user)
		else
			flash[:danger]  = "Smth wrong "
			render 'new'
		end
	end

	def update
		if @user && @user.authenticate(params[:user][:current_password])
			if @user.update_attributes(user_params)
				flash[:success] = "#{@user.email} was successfully updated."
				redirect_to @user
			else
				render :edit	
			end
		else
			flash[:danger] = "Current password invalid/not match !"
			render :edit
		end
	end

	def destroy
    	@user.destroy
		log_out if logged_in?
		flash[:danger] = 'Sad to know, You leaving us.'
    	redirect_to :root
  	end

private

	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		params.require(:user).permit(:nick_name, :email, :password, :password_confirmation)
	end
end