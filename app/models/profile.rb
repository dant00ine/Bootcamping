class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	belongs_to :profession

	has_and_belongs_to_many :bootcamps
end
