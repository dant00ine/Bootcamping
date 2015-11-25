class StatusesController < ApplicationController

	def index
		# @statuses = Status.all
	end

	def new
		# @status = Status.new
	end

	def create
		@dev_status = DevStatus.new(status_params)
		if @dev_status.save
			flash['success'] = "Status Successfully Created"
			redirect_to user_path(current_user)
		else
			flash['danger'] = "Nope not saved WRONG !!!!"
			render 'new'
		end
	end

private

	def status_params
		params.require(:dev_status).permit(:status, :profile_id, :bootcamp_id)
	end
end