class DevStatusesController < ApplicationController

	def index
		# @statuses = Status.all
	end

	def new
		# @status = Status.new
	end

	def create
		@dev_status = DevStatus.new(status_params)
		@dev_status.profile_id = current_user.profile.id
		# render plain: @dev_status.inspect

		if @dev_status.save
			flash['success'] = "Status Successfully Created"
			redirect_to user_path(current_user)
		else
			flash['danger'] = "Nope not saved WRONG !!!!"
			render 'new'
		end
	end

	def update
		user_bootcamp = current_user.profile.bootcamps
		@dev_status = DevStatus.find(user_bootcamp)
		puts @dev_status
		render plain: [params, @dev_status]
		# @dev_status.profile_id = current_user.profile.id
	end

	# def update
 #      if @bootcamp.update(bootcamp_params)
 #        redirect_to @bootcamp, notice: 'Bootcamp was successfully updated.'
 #      else
 #        render :edit
 #      end
 #  	end

private

	def status_params
		params.require(:dev_status).permit(:bootcamp_id)
	end
end