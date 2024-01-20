require 'rails_helper'

RSpec.feature "Book features", type: :feature do
  describe '#index' do
    let!(:author) { Author.create(name: 'Test Author1') }

    context 'empty index:' do
      before { visit '/books' }

      it "contains text 'Books'" do
        expect(page).to have_content('Books')
      end
    end

    context 'non-empty index' do
      let!(:book1) { author.books.create(title: 'Test', year: 1997) }
      let!(:book2) { author.books.create(title: 'Test1', year: 1998) }

      before (:each) do
        visit('/books')
      end

      it "contains book 1" do
        expect(page).to have_content(book1.title)
        expect(page).to have_content(book1.year)
        expect(page).to have_content(book1.author.name)
      end

      it "contains book 2" do
        expect(page).to have_content(book2.title)
        expect(page).to have_content(book2.year)
        expect(page).to have_content(book2.author.name)
      end
    end
  end

  describe '#create' do
    let!(:author) { Author.create(name: 'Test Author') }

    before(:each) do
      visit '/books'
      click_link('New Book')
    end

    it 'loads the page successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has the correct url' do
      expect(current_path).to eq('/books/new')
    end

    it 'has the title, year, and author fields' do
      expect(page).to have_field('book_title')
      expect(page).to have_field('book_year')
      expect(page).to have_field('book_author_id')
    end

    context 'when submit is pressed' do

      it 'successsfully creates a new Book with all inputs filled' do
        within('form') do
          fill_in 'book_title', with: 'Test'
          fill_in 'book_year', with: 1997
          select(author.name, from: 'book_author_id')
        end
        expect{ click_button 'Create Book' }.to change {Book.count}.by(1)
      end

      it 'successsfully creates a new Book and associates with chosen author' do
        within('form') do
          fill_in 'book_title', with: 'Test'
          fill_in 'book_year', with: 1997
          select(author.name, from: 'book_author_id')
        end
        expect{ click_button 'Create Book' }.to change {author.books.count}.by(1)
      end

      it 'displays the correct error messages when all inputs empty' do
        click_button 'Create Book'
        expect(page).to have_text('Title can\'t be blank')
        expect(page).to have_text('Title is too short (minimum is 2 characters)')
        expect(page).to have_text('Year can\'t be blank')
      end

      it 'doesn\'t create new book when no inputs filled' do
        click_button 'Create Book'
        expect{ click_button 'Create Book' }.to change {Book.count}.by(0)
      end

      it 'correctly displays error with title less than 2 characters' do
        within('form') do
          fill_in 'book_title', with: 't'
        end
        click_button 'Create Book'
        expect(page).to have_content('Title is too short (minimum is 2 characters)')
      end
    end
  end

  describe '#show' do
    let(:author) { Author.create(name: 'TestAuthor') }
    let!(:book) { author.books.create(title: 'TestBook', year: 1997) }

    before(:each) { visit "/books/#{book.id}" }

    it 'loads the page successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'displays the correct page' do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.year)
      expect(page).to have_content(book.author.name)
      expect(page).to have_link('Edit')
    end
  end

  describe '#edit' do
    let(:author1) { Author.create(name: 'TestAuthor1') }
    let(:author2) { Author.create(name: 'TestAuthor2') }
    let!(:book) { author1.books.create(title: 'TestBookBefore', year: 1997) }

    before(:each) do
      author1
      author2
      visit "/books/#{book.id}/edit"
    end

    it 'loads the page successfullly' do
      expect(page.status_code).to eq(200)
    end

    it 'displays the correct page' do
      expect(page).to have_content("Editing Book")
      expect(page).to have_content('Title')
      expect(page).to have_field('book_title')
      expect(page).to have_content('Year')
      expect(page).to have_field('book_year')
      expect(page).to have_field('book_author_id')
    end

    context 'when the edit page is submitted successfully' do
      before(:each) do
        within('form') do
          fill_in 'book_title', with: 'Edited'
          fill_in 'book_year', with: 2017
          select(author2.name, from: 'book_author_id')
        end
        click_button('Update Book')
      end

      it 'should redirect back to the correct book show page' do
        expect(current_path).to eq("/books/#{book.id}")
      end

      it 'should show the updated content' do
        expect(page).to have_content('Edited')
        expect(page).to have_content('2017')
        expect(page).to have_content(author2.name)
      end
    end
  end

  describe '#delete' do
    let(:author) { Author.create(name: 'TestAuthor') }

    context 'delete book' do
      let!(:book) { author.books.create(title: 'TestBook', year: 1997) }

      before(:each) do
        visit '/books'
      end

      it 'loads the page successfully' do
        visit "/books"
        expect(page.status_code).to eq(200)
        expect(page).to have_content(book.title)
      end

      it 'redirects back to the book index page' do
        click_link('Destroy')
        expect(current_path).to eq('/books')
      end

      it 'decreases the Book count by 1' do
        expect { click_link('Destroy') }.to change { Book.count }.by(-1)
      end

      it 'deletes the correct book' do
        click_link('Destroy')
        expect(Book.exists?(book.id)).to be false
      end

      it 'author not deleted' do
        click_link('Destroy')
        expect(Author.exists?(author.id)).to be true
      end
    end   
  end
end
