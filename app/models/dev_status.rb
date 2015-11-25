class DevStatus < ActiveRecord::Base
	belongs_to :profile
	belongs_to :bootcamp
end
