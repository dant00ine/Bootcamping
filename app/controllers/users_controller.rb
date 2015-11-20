class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new
	end

	def edit
	end

    def show
    end

	def create
        @user = User.new(user_params)
        if @user.save
            log_in(@user)
        	flash['success'] = "#{@user.email}, Suffessfully Registered !"
        	redirect_to root_path
        else
        	flash['danger'] = "smth went wrong !"
        	render 'new'
        end
    end

    def update
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
        else
          render 'edit'
        end
    end

    def destroy
        @user.destroy
        redirect_to root_path, notice: "#{@user.email} was successfully destroyed." 
    end

private
	def set_user
		@user = User.find(params[:id])
    end

	def user_params
		params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
	end
end
