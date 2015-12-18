class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update, :destroy]
	before_action :set_profile_and_bootcamps, only:[:edit, :update]

	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]
	# before_action :admin_user,     only: [:destroy]
	
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
		# @user = User.friendly.find(params[:user_id])

		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			User.create_profile_and_declare(@user) #calls User.Model to create Profile under the same ID, EMAIL of User!
			redirect_to edit_user_path(@user)
		else
			flash[:danger]  = "Something went wrong, Try again."
			render 'new'
		end
	end

	def update
		if @user && @user.authenticate(params[:user][:current_password])
			if @user.update_attributes(user_params)
				flash[:success] = "#{@user.email} was successfully updated."
				# redirect_to edit_user_path(@user)
				render :edit
			else
				render :edit
			end
		else
			flash[:danger] = "Current password did not Match."
			# render :edit
			redirect_to :back
		end
	end

    def update_profile
    	# @user = User.friendly.find(params[:user_id])
    	@user = User.find(params[:user_id])
    	
        @profile = @user.profile    	
        if @profile.update_attributes(profile_params)
            flash[:success] = "#{Profile.full_name(@profile)}: successfully updated." 
            redirect_to edit_user_path(@user)
        else
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

	def current_user?(user)
		(user == current_user) && (user.profile == current_user.profile)
	end
	def correct_user1
        # @user = User.friendly.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

	def set_profile_and_bootcamps
		@profile = @user.profile
		@bootcamps = Bootcamp.all
	end

	def set_user
		@user = User.find(params[:id])
      # @user = User.friendly.find(params[:id])
    end

	def user_params
		params.require(:user).permit(:nick_name, :email, :password, :password_confirmation)
	end

	def profile_params
        params.require(:profile).permit(:first_name, :last_name, :contact_phone, :contact_email, :contact_website, :image, :profession_id)
    end
end