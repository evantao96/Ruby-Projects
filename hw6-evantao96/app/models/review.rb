class Review < ApplicationRecord
  validates_presence_of :content
  validates_uniqueness_of :content

  belongs_to :course
end
