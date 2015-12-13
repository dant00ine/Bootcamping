class BootcampsController < ApplicationController
    before_action :only_bootcamp_owner?, except: [:index, :show]
    before_action :set_bootcamp, only: [:show, :edit, :update, :destroy]
    helper_method :rating_average

    # Post Method
    def bootcamp_comment_review
        bootcamp = Bootcamp.find_by(id: params[:bootcamp][:bootcamp_id])
        bootcamp.bootcamp_reviews.create(params.require(:bootcamp_review).permit(:review))
        bootcamp.bootcamp_comments.create(params.require(:bootcamp_comment).permit(:body))
        redirect_to :back
    end

    def index
        @bootcamps = Bootcamp.all
    end

    def show
        @stars_path = Dir.glob("app/assets/images/stars/*.png")
    end

    def new
        @bootcamp = Bootcamp.new
    end

    def edit
    end

    def create
        render plain: params
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

    def rating_average(bootcamp)
        if review = bootcamp.bootcamp_reviews.blank?
            review = 0
        else
            bootcamp.bootcamp_reviews.average(:review).round(2)
        end
    end

    def only_bootcamp_owner?
        redirect_to(root_path) unless current_user == "Owner of Bootcamp" #database need to design !!!
    end

    def set_bootcamp
        @bootcamp = Bootcamp.find(params[:id])
    end

    def bootcamp_params
        params.require(:bootcamp).permit(:title, :about, :image, :speciality, :location, :website, :email, :facebook, :twitter, :job_guarantee, :job_assistance, :apprenticeship, :accreditation, :post_grad_resources, :housing, :visa_assistance)
    end
end
