class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	belongs_to :users
	has_many :bootcamps
end
