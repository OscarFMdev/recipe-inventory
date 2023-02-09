class Recipe < ApplicationRecord
  before_create :set_recipe_number

  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :public, inclusion: { in: [true, false] }

  def recipe_number
    # get all recipes created by the same user as the current recipe
    user_recipes = Recipe.where(user_id: self.user_id)

    # find the position of the current recipe in the list of user recipes
    recipe_position = user_recipes.index(self) + 1

    # return the recipe position
    recipe_position
  end

  def set_recipe_number
    self.recipe_number = (Recipe.last.try(:recipe_number) || 0) + 1
  end

end
