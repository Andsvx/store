class Item < ApplicationRecord
  belongs_to :category

  has_many :comments

  has_many :cart_positions
  has_many :carts, through: :cart_positions

  has_many :order_positions
  has_many :orders, through: :order_positions

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0, allow_nil: true }

  before_destroy :check_usage

  serialize :images, JSON
  mount_uploaders :images, ImageUploader

  private

  def check_usage
    errors.add(:base, :used_in_cart) if cart_positions.present?
    errors.add(:base, :used_in_order) if order_positions.present?
    throw(:abort) if errors.present?
  end
end
