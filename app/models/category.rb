class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true

  before_destroy :check_usage

  acts_as_nested_set

  def childs
    Category.where(parent_id: id)
  end

  private

  def check_usage
    errors.add(:base, :is_parent) if childs.present?
    errors.add(:base, :includes_items) if items.present?
    throw(:abort) if errors.present?
  end
end
