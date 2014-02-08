class User < ActiveRecord::Base

	attr_accessor :password

	before_save :encrypt_password

	def encrypt_password
		if self.password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end


	def self.authenticate(email, password)
		user = User.where(email: email).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	has_many :foods
end

class Food < ActiveRecord::Base
	belongs_to :day
	belongs_to :user
end
