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
		
		search  = Location.find(params['location']) if params['location']
		search = Speciality.find(params['speciality']) if params['speciality']

		@search = search.bootcamps

		# render plain: params

	end
end
