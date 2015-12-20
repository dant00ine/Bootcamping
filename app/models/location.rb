class Location < ActiveRecord::Base
	# has_many :bootcamps

	has_and_belongs_to_many :bootcamps
end
