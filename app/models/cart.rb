class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_positions
  has_many :items, through: :cart_positions
end
