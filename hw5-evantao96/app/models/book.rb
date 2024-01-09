class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :year, presence: true
end
