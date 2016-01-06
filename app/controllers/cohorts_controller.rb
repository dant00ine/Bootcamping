class CohortsController < ApplicationController
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]
  before_action :set_bootcamp, only: [:index, :create]

  def index
    # @cohorts = Cohort.all
    @cohorts = @bootcamp.cohorts
  end

  def show
  end

  def new
    @cohort = Cohort.new
  end

  def edit
  end

  def create
    # @cohort = Cohort.new(cohort_params)

    cohort = @bootcamp.cohorts.new(cohort_params)

      if cohort.save
        redirect_to @bootcamp, notice: 'Cohort was successfully created.'
      else
        render :new
      end
  end

  def update
    respond_to do |format|
      if @cohort.update(cohort_params)
        format.html { redirect_to @cohort, notice: 'Cohort was successfully updated.' }
        format.json { render :show, status: :ok, location: @cohort }
      else
        format.html { render :edit }
        format.json { render json: @cohort.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cohort.destroy
    respond_to do |format|
      format.html { redirect_to cohorts_url, notice: 'Cohort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cohort
      @cohort = Cohort.find(params[:id])
    end

    def set_bootcamp
      @bootcamp = Bootcamp.find(params[:bootcamp_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cohort_params
      params.require(:cohort).permit(:month)
    end
end
