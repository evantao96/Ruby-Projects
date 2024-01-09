require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'when Authors are created' do

    it 'increases Author count by 1' do
      expect { Author.create(name: 'Test') }.to change { Author.count }.by(1)
    end

  end

  describe '#books' do
    subject { Author.create(name: 'Example') }

    it 'has no Books by default' do
      expect(subject.books).to be_empty
    end

    context 'when 1 Book is added to author\'s books' do
      it 'increases author\'s Books count by 1' do
        expect { Book.create(title: 'Hello', year: 1997, author: subject) }.to change { subject.books.count }.by(1)
      end
    end

    context 'when Books are added' do
      let!(:book1) { Book.create(title: 'Hello', year: 1997, author: subject) }
      let!(:book2) { Book.create(title: 'Bye', year: 1997, author: subject) }

      it 'can have many Books' do
        expect(subject.books).to eq([book1, book2])
      end
    end

    context 'when Books are added via Author model' do
      let!(:book1) { subject.books.create(title: 'Hello', year: 1997) }
      let!(:book2) { subject.books.create(title: 'Bye', year: 1997) }

      it 'can have many Books' do
        expect(subject.books).to eq([book1, book2])
      end
    end

    context 'when Author deleted' do
      let!(:book1) { subject.books.create(title: 'Hello', year: 1997) }
      let!(:book2) { subject.books.create(title: 'Bye', year: 1997) }

      it 'author\'s books are deleted as well' do
        expect { subject.destroy }.to change { Book.count }.by(-2)
        expect(Book.exists?(book1.id)).to be false
        expect(Book.exists?(book2.id)).to be false
      end
    end
  end
end
