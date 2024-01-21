class Note < ApplicationRecord

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true

end
