class Order < ApplicationRecord
  belongs_to :user

  has_many :order_positions
  has_many :items, through: :order_positions

  validates :address, :phone_number, presence: true
end
