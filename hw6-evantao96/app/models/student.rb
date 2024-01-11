class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, scope: :last_name
end