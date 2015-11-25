class ProfilesController < ApplicationController
  before_action :user_profile, only: [:create, :new, :show, :edit]
  before_action :only_current_user
  before_action :all_bootcamps, only: [:new, :edit]

  def new
    @profile = Profile.new
    @dev_statuses = DevStatus.all
  end

  def edit
    @profile = @user.profile
    @dev_statuses = DevStatus.all
  end

  def create
    @profile = @user.build_profile(profile_params)
      if @profile.save
        redirect_to @user, notice: 'Profile was successfully created.'
      else
        render :new
      end
  end

  def update
    # render plain: params
    @profile = @user.profile
      if @profile.update_attributes(profile_params)
        redirect_to @user, notice: 'Profile was successfully updated.'
      else
        render :edit 
      end
  end

private

    def all_bootcamps
      @bootcamps = Bootcamp.all
      @professions = Profession.all
    end

    def user_profile
      @user = User.find(params[:user_id])
    end

    def profile_params
      params.require(:profile).permit(:nick_name, :first_name, :last_name, :contact_phone, :contact_email, :contact_website, :image, :profession_id)
    end

    def only_current_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless @user == current_user
    end
end
