require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:author) { Author.create(name: 'Test Author') }

  context 'creating a Book through an author' do
    it 'increases Book count by 1' do
      expect { author.books.create(title: 'Test Book', year: 1997) }.to change { Book.count }.by(1)
    end
  end

  context 'creating a Book directly' do
    it 'increases Book count by 1' do
      expect { Book.create(title: 'Test Book2', year: 1997, author: author) }.to change { Book.count }.by(1)
    end
  end

  describe '#author' do
    context 'when a book is created' do
      let!(:book1) { Book.create(title: 'Just Another Test Book', year: 1999, author_id: author.id) }

      it 'always has an associated Author' do
        expect(book1.author).to eq(author)
      end
    end

    context 'when a book is created via the Author model' do
      let!(:book1) { author.books.create(title: 'Another Test Book', year: 1998) }

      it 'always has an associated Author' do
        expect(book1.author).to eq(author)
      end
    end
  end
end
