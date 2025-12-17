class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
