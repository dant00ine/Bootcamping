class ProfilesController < ApplicationController
  before_action :user_profile, only: [:create, :new, :show, :edit]
  before_action :only_current_user
  before_action :all_bootcamps_professions, only: [:new, :edit]

  def new
    @profile = Profile.new
  end

  def edit
    @profile = @user.profile
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

    def bootcamps_add
        x = params[:bootcamps] 
        x ? x = params[:bootcamps]['ids'] : x = []
        current_user.profile.bootcamp_ids = x
        flash[:success] = "Yeah Added Bootcamps"
        redirect_to :back
    end

    def bootcamps_update
        x = params[:bootcamps] 
        x ? x = params[:bootcamps]['ids'] : x = []
        current_user.profile.bootcamp_ids = x
        flash[:success] = "Yeah Updated Bootcamps"
        redirect_to :back
    end

private

    def all_bootcamps_professions
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
