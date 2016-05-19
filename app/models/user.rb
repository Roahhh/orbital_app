class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_save { self.email = email.downcase, 
		          self.identity_no = identity_no.upcase }

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, length: {maximum: 255}, 
	           format: { with: VALID_EMAIL_REGEX },
	           uniqueness: { case_sensitive: false }
    validates :identity_no, length: {maximum: 20}, presence: true,
	           uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }

	has_secure_password

end
