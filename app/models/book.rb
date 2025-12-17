class Book < ApplicationRecord
  has_one_attached :image

  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :price, numericality: { greater_than: 0 }


end
