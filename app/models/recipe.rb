class Recipe < ApplicationRecord
  before_create :set_recipe_number

  attr_accessor :recipe_sequence_number

  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :public, inclusion: { in: [true, false] }

  def recipe_number
    user_recipes = Recipe.where(user_id:)
    user_recipes.index(self) + 1
  end

  def set_recipe_number
    self.recipe_sequence_number = (Recipe.last.try(:recipe_sequence_number) || 0) + 1
  end
end
