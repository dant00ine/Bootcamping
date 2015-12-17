class BootcampReviewsController < ApplicationController
	before_action :authenticate, only: [:create]

	def create
		bootcamp = Bootcamp.find_by(id: params[:bootcamp_id])
		camp = bootcamp.bootcamp_reviews.build(bootcamp_review_params)
		camp.profile_id = current_user.id

		if camp.save
			flash['success'] = "YEAHHHHH #{camp.body}"
			redirect_to :back
		else
			@bootcamp = Bootcamp.find(params[:bootcamp_id])
			render 'bootcamps/show'
		end
	end
private

	def bootcamp_review_params
		params.require(:bootcamp_review).permit(:rating, :body)
	end

	def authenticate
		# authenticate_or_request_with_http_basic do |name, password|
		# 	name =="admin" && password == "secret"
		# end
		redirect_to :root if current_user == nil
    end
end