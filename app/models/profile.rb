class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	belongs_to :user
	belongs_to :profession
	has_many :bootcamp_review, dependent: :destroy
	has_and_belongs_to_many :bootcamps, dependent: :destroy

	# validates :profession_id, presence: true
	# validates :first_name, presence: true, length: { minimum:3, maximum: 50 }
	# validates :last_name, presence: true, length: { minimum:3, maximum: 50 }

	# validates :phone, format: {with: /\A[0-9]{3}-[0-9]{3}-[0-9]{4}+\z/}


	def self.full_name(id)
		user = Profile.find_by(id: id)
		"#{user.first_name} #{user.last_name}"
	end

end
