class BootcampReview < ActiveRecord::Base
	belongs_to :bootcamp
	belongs_to :profile

	validates :rating, :body, presence: true
end
