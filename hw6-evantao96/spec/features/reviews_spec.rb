require 'rails_helper'

RSpec.feature "Reviews", type: :feature do
  let!(:course) { Course.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }

  let!(:review1_content) { 'Review 1' }
  let!(:review1_params) { { content: review1_content } }

  let!(:review2_content) { 'Review 2' }
  let!(:review2_params) { { content: review2_content } }

  describe '#edit' do
    let!(:review) { course.reviews.create(review1_params) }

    before(:each) { visit "/courses/#{course.id}/reviews/#{review.id}/edit" }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has the content of the review to be edited' do
      expect(page).to have_text(review1_content)
    end
  end

  describe '#create' do
    before(:each) do
      visit "/courses/#{course.id}"
      fill_in 'review_content', with: review1_content
      click_button 'Add Review'
    end

    it 'redirects to course\'s show page' do
      expect(current_path).to eq("/courses/#{course.id}")
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has content of newly created review' do
      expect(page).to have_text(review1_content)
    end
  end

  describe '#update' do
    let(:review) { course.reviews.create(review1_params) }
    
    before(:each) do
      visit "courses/#{course.id}/reviews/#{review.id}/edit"
      fill_in 'review_content', with: review2_content
      click_button 'Update Review'
    end

    it 'redirects to the course\'s show page' do
      expect(current_path).to eq("/courses/#{course.id}")
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'does not have the content of the review before update' do
      expect(page).to_not have_text(review1_content)
    end

    it 'has the content of the review after update' do
      expect(page).to have_text(review2_content)
    end
  end

  describe '#destroy' do
    let!(:review) { course.reviews.create(review1_params) }

    before(:each) { visit "/courses/#{course.id}" }

    it 'has the content of the review before delete' do
      expect(page).to have_text(review1_content)
    end

    context 'when delete button is pressed' do
      before(:each) { find("a[href='/courses/#{course.id}/reviews/#{review.id}']").click }

      it 'redirects to the course\'s show page' do
        expect(current_path).to eq("/courses/#{course.id}")
      end

      it 'loads the page successfully' do
        expect(status_code).to eq(200)
      end

      it 'does not have the content of the deleted review' do
        expect(page).to_not have_text(review1_content)
      end
    end
  end
end
