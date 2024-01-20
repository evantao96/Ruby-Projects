require 'rails_helper'

RSpec.describe Student, type: :model do
  let!(:student) { Student.create(first_name: 'First', last_name: 'Student') }
  let!(:course1) { Course.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }
  let!(:course2) { Course.create(title: 'CIS 197', description: 'Javascript') }

  it 'has and belongs to many courses' do
    student.courses << course1
    student.courses << course2

    expect(student.courses).to include(course1)
    expect(course1.students).to include(student)
    expect(student.courses).to include(course2)
    expect(course2.students).to include(student)
  end

  describe '#full_name' do
    it 'returns the student\'s full name' do
      expect(student.full_name).to eq("#{student.first_name} #{student.last_name}")
    end
  end
end
