class BootcampsController < ApplicationController
    before_action :authenticated?, except: [:index, :show]
    before_action :set_bootcamp, only: [:show, :edit, :update, :destroy, :only_bootcamp_owber?]
    before_action :only_bootcamp_owner?, only: [:edit, :update]
    before_action :admin_user, only: :destroy
    
    def index
        @bootcamps = Bootcamp.paginate(page: params[:page])
    end

    def show
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
        redirect_to :root; flash[:danger] = "Not allowed !" if current_user.profile.bootcamp_admin != @bootcamp.id
    end

    def set_bootcamp
        @bootcamp = Bootcamp.find(params[:id])
    end

    def bootcamp_params
        params.require(:bootcamp).permit(:title, :about, :image, :image_url, :speciality, :location, :website, :email, :facebook, :twitter, :job_guarantee, :job_assistance, :apprenticeship, :accreditation, :post_grad_resources, :housing, :visa_assistance)
    end
end
