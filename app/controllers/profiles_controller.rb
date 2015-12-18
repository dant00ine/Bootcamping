class ProfilesController < ApplicationController
  before_action :user_profile_set, only: [:edit, :update, :correct_user, :bootcamps_add, :bootcamps_update]
  before_action :correct_user, only: [:edit, :update]
  before_action :all_bootcamps_professions, only: [:edit]

    # def edit
    #     @profile = @user.profile
    # end

    # def create
    #     @profile = @user.build_profile(profile_params)
    #     if @profile.save
    #         redirect_to @user, notice: 'Profile was successfully created.'
    #     else
    #         render :new
    #     end
    # end

    # def update
    #     @profile = @user.profile

    #     if @profile.update_attributes(profile_params)
    #         flash[:success] = "#{Profile.full_name(@profile)}: successfully updated." 
    #         redirect_to edit_user_path(@user)
    #     else
    #         flash[:danger] = "#{@profile.errors.full_messages}" 
    #         # redirect_to edit_user_path(@user)
    #         render :back
    #     end
    # end

    def bootcamps_add
        # render plain: params
        x = params[:bootcamps] 
        x ? x = x['ids'] : x = []
        if x.length != 0
            if x.length <= 2
                @user.profile.bootcamp_ids = x
                flash[:success] = "Yeah Added Bootcamps"
            else
                flash[:danger] = "You can only pick 3 or less Bootcamps."
            end
        else
            flash[:danger] = "You have not checked None."
        end
        redirect_to :back
    end

    def bootcamps_update
        x = params[:bootcamps] 
        x ? x = x['ids'] : x = []
        if x.length <= 2
            @user.profile.bootcamp_ids = x 
            flash[:success] = "Yeah Added Bootcamps"
        else
            flash[:danger] = "You can only pick 3 or less Bootcamps."
        end
        redirect_to :back
    end

private

    # def all_bootcamps_professions
    #     @bootcamps = Bootcamp.all
    #     @professions = Profession.all
    # end

    def user_profile_set
        # @user = User.friendly.find(params[:user_id])
        @user = User.find(params[:user_id])
    end

    # def profile_params
    #     params.require(:profile).permit(:first_name, :last_name, :contact_phone, :contact_email, :contact_website, :image, :profession_id)
    # end

end
