class User < ActiveRecord::Base
    attr_accessor :remember_token
    # extend FriendlyId
    # friendly_id :nick_name, use: [:slugged, :history, :finders]
    
    has_one :profile, dependent: :destroy

    before_save { self.email = email.downcase }
    # validates :nick_name, format: {with: /\A[A-Za-z ]+\z/}
    validates :nick_name, format: {with: /\A[a-z\d]*\Z/i}
    validates_length_of :nick_name, :in => 3..15, :on => :update
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 2 }, allow_nil: true


    # def nick_name_generate_new_friendly_id?
    #     nick_name_changed?
    # end

class << self

    def create_profile_and_declare(user)
        user.create_profile(id: user.id, user_id: user.id, contact_email: user.email)
    end

    # Returns the hash digest of the given string.
  	def digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

	# Returns a random token.
	def new_token
    	SecureRandom.urlsafe_base64
	end
end #end of Self class

	def remember
    	self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
    	update_attribute(:remember_digest, nil)
	end

end