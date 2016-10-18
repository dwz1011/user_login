# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  password_digest  :string(255)
#  remember_ddigest :string(255)
#  remember_digest  :string(255)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
	attr_accessor :remember_token
	before_save { self.email = email.downcase }	#把用户的email地址转换成小写
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness:  { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	class << self
	#返回指定字符串的哈希摘要
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    		BCrypt::Password.create(string, cost: cost)
		end

		#返回一个随机令牌
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	#在数据库中记住用户
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#如果指定的令牌和摘要匹配，返回true
	def autenticated?(remember_token)  #autenticated?类似与has_secure_password提供的autenticated的方法
		BCrypt::Password.new(remember_digest).is_password?(remember_token)	#确认记忆令牌与用户的记忆摘要匹配
	end
end
