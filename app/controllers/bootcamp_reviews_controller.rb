class BootcampReviewsController < ApplicationController
	
	def new
		@review = BootcampReview.new
	end

	def create
		bootcamp = Bootcamp.find_by(id: params[:bootcamp_id])		
		profile = current_user.profile
		camp = profile.build_bootcamp_review(bootcamp_review_params)
		camp.bootcamp_id = bootcamp.id
		if camp.save
			flash['success'] = "YEAHHHHH #{camp}"
			redirect_to :back
		else
			render :back
		end
	end
private

	def bootcamp_review_params
		params.require(:bootcamp_review).permit(:rating, :body)
	end
end