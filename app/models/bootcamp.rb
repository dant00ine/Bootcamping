class Bootcamp < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	has_and_belongs_to_many :profiles
	has_many :bootcamp_reviews, dependent: :destroy
end
