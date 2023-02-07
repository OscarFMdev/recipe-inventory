class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :measurement, presence: true, length: { maximum: 20 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
