class Bootcamp < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	# its many to many through dev_statuses
	has_many :dev_statuses
	has_many :profiles, through: :dev_statuses

end
