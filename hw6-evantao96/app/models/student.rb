class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, scope: :last_name

  has_many :students_courses, dependent: :destroy
  has_many :courses, through: :students_courses

  def full_name
    first_name << " " << last_name
  end

end
