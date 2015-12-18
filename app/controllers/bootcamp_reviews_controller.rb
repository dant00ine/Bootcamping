class BootcampReviewsController < ApplicationController
	before_action :authenticate, only: [:create]
	
	def authenticate
		# authenticate_or_request_with_http_basic do |name, password|
		# 	name =="admin" && password == "secret"
		# end
		redirect_to :root if current_user == nil
    end
end