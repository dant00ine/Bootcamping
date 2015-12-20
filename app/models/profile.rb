class Profile < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	
	belongs_to :user
	belongs_to :profession
	has_many :bootcamp_reviews, dependent: :destroy
	has_and_belongs_to_many :bootcamps, dependent: :destroy

	validates_numericality_of :profession_id, presence: true, :only_integer => true, :on => :update

	# validates_numericality_of :vacants, :greater_than_or_equal_to => 0,  
    #validates_numericality_of :price, :greater_than_or_equal_to => 0,  :only_integer => true
    # validates_length_of :first_name, :last_name, :in => 3..15, format: {with: /\A[A-Za-z]+\z/}, :on => :update

	validates :first_name, :last_name, presence: true, length: { minimum:3, maximum: 20 }, 
													   format: {with: /\A[A-Za-z]+\z/}, :on => :update    
    # validates :image, presence: {message: "cannot be blank. Please, Upload an image"}, :on => :update
	validates :contact_phone, 
	          format: {with: /\A[0-9]{3}[0-9]{3}[0-9]{4}+\z/, message: "%{value} is not valid phone number" }, 
	          :on => :update
    		  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :contact_email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false},
                    format: { with: VALID_EMAIL_REGEX, message: "Email cannot be Blank!"}, :on => :update


	def self.full_name(obj)
		user = Profile.find_by(id: obj)
		"#{user.first_name} #{user.last_name}"
	end

end
