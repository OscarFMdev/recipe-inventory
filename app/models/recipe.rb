class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :preparation_time, presence: true, length: { minimum: 5 }
  validates :cooking_time, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
end