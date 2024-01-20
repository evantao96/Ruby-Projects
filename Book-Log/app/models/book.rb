class Book < ApplicationRecord

  belongs_to :author
  
  validates :title, presence: true, length: { minimum: 2 }
  validates :year, presence: true
end
