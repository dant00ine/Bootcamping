class Bootcamp < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	has_many :cohorts, dependent: :destroy
	has_and_belongs_to_many :locations
	has_and_belongs_to_many :specialities

	has_and_belongs_to_many :profiles
	has_many :bootcamp_reviews, dependent: :destroy

	validates :title, presence: true, length: { minimum:3, maximum: 55}
end
