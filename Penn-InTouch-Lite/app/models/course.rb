class Course < ApplicationRecord
  validates_presence_of :title, :description
  validates_uniqueness_of :title

  has_many :reviews, dependent: :destroy
  has_many :students_courses, dependent: :destroy
  has_many :students, through: :students_courses
end
