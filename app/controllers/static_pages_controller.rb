class StaticPagesController < ApplicationController
	
	def index
	end

	def about
	end

	def search
		# if params[:location]
		# 	x = Location.find(params[:location])
		# 	@search = x.bootcamps
		# elsif params[:speciality]
		# 	x = Speciality.find(params[:speciality])
		# 	@search = x.bootcamps
		# end
		# render :search
		loc = Location.find(params[:search]['location_id'])
		render plain: loc
	end
end
