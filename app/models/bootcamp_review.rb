class BootcampReview < ActiveRecord::Base
	belongs_to :bootcamp

	validates :review, presence: true
end
