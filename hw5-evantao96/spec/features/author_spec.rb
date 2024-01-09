require 'rails_helper'

RSpec.feature "Author_features", type: :feature do
  describe '#index' do
    context 'empty index' do
      before { visit '/authors' }

      it "contains text Authors" do
        expect(page).to have_content('Authors')
      end
    end

    context 'non-empty index' do
      let!(:author1) { Author.create(name: 'Test Author1') }
      let!(:author2) { Author.create(name: 'Test Author2') }

      before (:each) do
        visit('/authors')
      end

      it "contains author 1" do
        expect(page).to have_content(author1.name)
      end

      it "contains author 2" do
        expect(page).to have_content(author2.name)
      end
    end
  end

  describe '#create' do
    before(:each) do
      visit '/authors'
      click_link('New Author')
    end

    it 'loads the page successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has the correct url' do
      expect(current_path).to eq('/authors/new')
    end

    it 'has the name field' do
      expect(page).to have_field('author_name')
    end

    context 'when submit is pressed:' do

      it 'successsfully creates a new Author with all inputs filled' do
        within('form') do
          fill_in 'author_name', with: 'Test'
        end
        expect{ click_button 'Create Author' }.to change {Author.count}.by(1)
      end

      it 'displays the correct error messages when all inputs empty' do
        click_button 'Create Author'
        expect(page).to have_text('Name can\'t be blank')
        expect(page).to have_text('Name is too short (minimum is 2 characters)')
      end

      it 'doesn\'t create new author when no inputs filled' do
        click_button 'Create Author'
        expect{ click_button 'Create Author' }.to change {Author.count}.by(0)
      end

      it 'correctly displays error with name less than 2 characters' do
        within('form') do
          fill_in 'author_name', with: 't'
        end
        click_button 'Create Author'
        expect(page).to have_content('Name is too short (minimum is 2 characters)')
      end
    end
  end

  describe '#view' do
    let(:author) { Author.create(name: 'TestName') }

    before(:each) { visit "/authors/#{author.id}" }

    it 'loads the page successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'displays the correct page' do
      expect(page).to have_content('TestName')
      expect(page).to have_link('Edit Author')
    end

    context 'there are no listed books' do
      it 'should ask to add books' do
        expect(page).to have_content("No books listed for #{author.name} yet! Add a book with the button below")
      end
    end

    context 'there are listed books' do
      let!(:book) { author.books.create(title: 'TestBook', year: 2017) }

      it 'should load the books' do
        visit current_path
        expect(page).to have_content('TestBook')
        expect(page).to have_content('2017')
      end
    end
  end

  describe '#edit' do
   let(:author) { Author.create(name: 'Before Name') }

    before(:each) do
      visit "/authors/#{author.id}/edit"
    end

    it 'loads the page successfullly' do
      expect(page.status_code).to eq(200)
    end

    it 'displays the correct page' do
      expect(page).to have_content("Editing Author")
      expect(page).to have_content('Name')
      expect(page).to have_field('author_name')
    end

    context 'when the edit page is submitted successfully' do
      before(:each) do
        within('form') do
          fill_in 'author_name', with: 'Edited Name'
        end
        click_button('Update Author')
      end

      it 'should redirect back to the correct author show page' do
        expect(current_path).to eq("/authors/#{author.id}")
      end

      it 'should show the updated content' do
        expect(page).to have_content('Edited Name')
      end
    end
  end

  describe '#delete' do

    context 'delete author' do
      let!(:author) { Author.create(name: 'Name') }

      before(:each) do
        visit '/authors'
      end

      it 'loads the page successfully' do
        visit "/authors"
        expect(page.status_code).to eq(200)
        expect(page).to have_content(author.name)
      end

      it 'redirects back to the author index page' do
        click_link('Destroy')
        expect(current_path).to eq('/authors')
      end

      it 'decreases the Author count by 1' do
        expect { click_link('Destroy') }.to change { Author.count }.by(-1)
      end

      it 'deletes the correct author' do
        click_link('Destroy')
        expect(Author.exists?(author.id)).to be false
      end
    end

    context 'when destroy button clicked and associated books exist' do
      let!(:author) { Author.create(name: 'Name') }
      let!(:book1) { author.books.create(title: 'Book', year: 2017) }
      let!(:book2) { author.books.create(title: 'Book1', year: 2018) }

      before(:each) do
        visit '/authors'
      end

      it 'removes the books' do
        click_link('Destroy')
        expect(Book.exists?(book1.id)).to be false
        expect(Book.exists?(book2.id)).to be false
      end

      it 'decreases the book count by |author.books|' do
        expect { click_link('Destroy') }.to change { Book.count }.by(-2)
      end
    end    
  end
end
