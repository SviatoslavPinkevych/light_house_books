class Order < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :first_name, :last_name, :phone, :delivery_method, presence: true
  validates :payment_method, presence: true
end
