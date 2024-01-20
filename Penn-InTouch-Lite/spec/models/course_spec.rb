require 'rails_helper'

RSpec.describe Course, type: :model do
  let!(:course) { Course.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }
  let!(:student1) { Student.create(first_name: 'First', last_name: 'Student') }
  let!(:student2) { Student.create(first_name: 'Second', last_name: 'Student') }
  let!(:review1) { course.reviews.create(content: 'First Review') }
  let!(:review2) { course.reviews.create(content: 'Second Review') }

  it 'has and belongs to many students' do
    course.students << student1
    course.students << student2

    expect(course.students).to include(student1)
    expect(student1.courses).to include(course)
    expect(course.students).to include(student2)
    expect(student2.courses).to include(course)
  end

  it 'has many reviews' do
    expect(course.reviews).to include(review1)
    expect(course.reviews).to include(review2)
  end

  it 'deletes associated reviews' do
    expect { course.destroy }.to change(Review, :count).by(-2)
  end
end
