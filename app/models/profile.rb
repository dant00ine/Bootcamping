class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	belongs_to :profession

	# its many to many through dev_statuses
	has_many :dev_statuses
	has_many :bootcamps, through: :dev_statuses
end
