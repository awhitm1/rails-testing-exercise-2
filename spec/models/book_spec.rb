require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validation tests' do
    it 'is not valid without an author' do
      author = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
      book = Book.create(title: Faker::Book.title)

      expect(book).to_not be_valid
    end

    it 'is invalid with an invalid author' do
      author = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
      book = Book.create(title: Faker::Book.title, author_id: 3)

      expect(book).to be_invalid
    end

    it 'is valid with a valid author' do
      author = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
      book = Book.create(title: Faker::Book.title, author_id: author.id)

      expect(book).to be_valid
    end
  end

  context 'Association tests' do
    it 'belongs to an author' do
      author = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
      book = Book.create(title: Faker::Book.title, author_id: author.id)

      expect(book.author).to eq(author)
    end
  end

  context 'access tests' do
    it 'should return all books of an author' do
      author = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
      book1 = Book.create(title: Faker::Book.title, author_id: author.id)
      book2 = Book.create(title: Faker::Book.title, author_id: author.id)
      book3 = Book.create(title: Faker::Book.title, author_id: author.id)

      expect(author.books).to eq([book1, book2, book3])
    end

    context 'deletion tests' do
      it 'should delete all books of an author' do
        author1 = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
        author2 = Author.create(name: Faker::Book.author, bio: Faker::Lorem.sentence(word_count: 3))
        book1 = Book.create(title: Faker::Book.title, author_id: author1.id)
        book2 = Book.create(title: Faker::Book.title, author_id: author1.id)
        book3 = Book.create(title: Faker::Book.title, author_id: author2.id)
        book4 = Book.create(title: Faker::Book.title, author_id: author2.id)

        expect { author2.destroy }.to change { Book.count }.by(-2)
      end
      
    end
  end

end
