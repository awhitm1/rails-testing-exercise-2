class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true
  validates :author, presence: true
end
