require 'rails_helper'

RSpec.feature "Welcome_features", type: :feature do
  before(:each) { visit '/' }

  describe '#index' do
    it 'has a Heading 1 with text Book Log' do
      expect(page).to have_selector 'h1', text: 'Book Log'
    end

    it 'has a welcome paragraph' do
      expect(page).to have_selector 'p', count: 1
    end

    it 'has a Heading 3 with text My Favorite Books:' do
      expect(page).to have_selector 'h3', text: 'My Favorite Books:'
    end

    it 'has an ordered list' do
      expect(page).to have_selector 'ol', count: 1
    end

    it 'has three italicized list items in the ordered list' do
      expect(page).to have_selector 'ol li em', count: 3
    end

    it 'has a link to the authors index page' do
      expect(page).to have_link 'See all Authors', href: '/authors'
    end

    it 'has a link to the books index page' do
      expect(page).to have_link 'See all Books', href: '/books'
    end
  end
end
