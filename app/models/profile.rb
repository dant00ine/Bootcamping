class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	belongs_to :profession
	has_and_belongs_to_many :bootcamps

	# validates :profession_id, presence: true
	# validates :nick_name, presence: true, length: { minimum:3, maximum: 50 }
	# validates :first_name, presence: true, length: { minimum:3, maximum: 50 }
	# validates :last_name, presence: true, length: { minimum:3, maximum: 50 }
end
