class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	belongs_to :user
	belongs_to :profession
	has_many :bootcamp_reviews, dependent: :destroy
	has_and_belongs_to_many :bootcamps, dependent: :destroy

	validates_numericality_of :profession_id, presence: true, :only_integer => true, :on => :update

	# validates_numericality_of :vacants, :greater_than_or_equal_to => 0,  
    #validates_numericality_of :price, :greater_than_or_equal_to => 0,  :only_integer => true

	validates :first_name, :last_name, presence: true, length: { minimum:3, maximum: 15 }, 
													   format: {with: /\A[A-Za-z]+\z/}, :on => :update
    # validates :image, presence: true, :on => :update
	validates :contact_phone, format: {with: /\A[0-9]{3}-[0-9]{3}-[0-9]{4}+\z/}, :on => :update


	def self.full_name(obj)
		user = Profile.find_by(id: obj)
		"#{user.first_name} #{user.last_name}"
	end

end
