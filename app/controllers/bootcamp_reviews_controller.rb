class BootcampReviewsController < ApplicationController

	def new
		@review = BootcampReview.new
	end

	def create
		@bootcamp = Bootcamp.find(params[:bootcamp_id])
		@review = @bootcamp.bootcamp_reviews.create(bootcamp_review_params)
		redirect_to :back
	end
private

	def bootcamp_review_params
		params.require(:bootcamp_review).permit(:review, :bootcamp_id)
	end
end