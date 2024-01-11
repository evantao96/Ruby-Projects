require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'belongs to a course' do
    course = Course.create(title: 'CIS 196', description: 'Ruby on Rails Web Development')
    review = Review.create(course: course, content: 'First Review')
    expect(review.course).to eq(course)
  end
end
