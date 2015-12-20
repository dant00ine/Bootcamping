class BootcampsController < ApplicationController
    before_action :logged_in_user, except: [:index, :show]
    before_action :set_bootcamp, only: [:show, :edit, :update, :destroy, :only_bootcamp_owber?]
    before_action :only_bootcamp_owner?, only: [:edit, :update]
    before_action :admin_user, only: [:new, :create, :destroy]

    def review
        @bootcamp = Bootcamp.find(params[:bootcamp_id])
        @bootcamp_review = @bootcamp.bootcamp_reviews.build(bootcamp_review_params)
        @bootcamp_review.profile_id = current_user.id

        if @bootcamp_review.save
            flash['success'] = "YEAHHHHH #{@bootcamp_review.body}"
            redirect_to bootcamp_path(@bootcamp)
        else
            render :show
        end
    end
    
    def index
        @bootcamps = Bootcamp.paginate(page: params[:page])
    end

    def show
        @bootcamp_review = @bootcamp.bootcamp_reviews.build
    end

    def new
        @bootcamp = Bootcamp.new
    end

    def edit
    end

    def create
        @bootcamp = Bootcamp.new(bootcamp_params)
        if @bootcamp.save
            redirect_to @bootcamp, notice: 'Bootcamp was successfully created.'
        else
            render :new
        end
    end

    def update
        if @bootcamp.update(bootcamp_params)
            redirect_to @bootcamp, notice: 'Bootcamp was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @bootcamp.destroy
        redirect_to bootcamps_url, notice: 'Bootcamp was successfully destroyed.'
    end

private

    def only_bootcamp_owner?
        if current_user.profile.bootcamp_admin != @bootcamp.id
            flash[:danger] = "This Bootcamp not belongs to you."
            redirect_to :root
        end
    end

    def set_bootcamp
        @bootcamp = Bootcamp.find(params[:id])
    end

    def bootcamp_review_params
        params.require(:bootcamp_review).permit(:rating, :body)
    end

    def bootcamp_params
        params.require(:bootcamp).permit(:title, :about, :image, :remote_image_url, :speciality, :location, :website, :email, :facebook, :twitter, :job_guarantee, :job_assistance, :apprenticeship, :accreditation, :post_grad_resources, :housing, :visa_assistance)
    end
end
