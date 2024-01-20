require 'bcrypt'

class User < ApplicationRecord

	has_many :statuses, dependent: :destroy
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships

	validates :name, presence: true, length: { minimum: 2}
	validate :name, :capitalized?
	validates :email, presence: true, uniqueness: true
	
	include BCrypt

	def capitalized?
		unless name[0, 1] == name[0, 1].upcase
			errors.add(:name, "is not capitalized.")
		end
	end

	def password
		unless password_hash.nil?
    		@password ||= Password.new(password_hash)
    	end
  	end

  	def password=(new_password)
    	@password = Password.create(new_password)
    	self.password_hash = @password
  	end

  	def remove_friendship(friend)
  		f1 = Friendship.find_by(user: self, friend: friend)
  		unless f1.nil?
  			f1.destroy
  		end
		f2 = Friendship.find_by(user: friend, friend: self)
		unless f2.nil? 
			f2.destroy
		end
	end

	def send_friend_request(friend)
		unless Friendship.exists?(user: self, friend: friend)
			f = Friendship.create(user: self, friend: friend, status: 'pending')
		end
	end

	def accept_friend_request(friend)
		f1 = Friendship.find_or_create_by(user: self, friend: friend)
		f1.update(status: 'accepted')
		f2 = Friendship.find_or_create_by(user: friend, friend: self)
		f2.update(status: 'accepted')
	end

	def accepted_friends
    	friendships.where(status: 'accepted').map(&:friend)
  	end

  	def outgoing_friend_requests
    	friendships.where(status: 'pending').map(&:friend)
  	end

  	def incoming_friend_requests
    	Friendship.where(friend: self, status: 'pending').map(&:user)
  	end
end
