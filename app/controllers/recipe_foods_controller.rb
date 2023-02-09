class RecipeFoodsController < ApplicationController
  def new
    recipe = Recipe.find(params[:recipe_id])
    unless recipe.user == current_user
      flash[:alert] =
        'You do not have access to add an ingredient on a recipe that does not belong to you.'
      return redirect_to recipes_path
    end

    @recipe_food = RecipeFood.new
    @foods = current_user.foods
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    recipe_food = RecipeFood.new(recipe_food_params)
    recipe_food.recipe = @recipe

    if recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'New ingredient was successfully added.'
    else
      flash[:alert] = 'New Ingredient adding Failed. Please try again.'
    end
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])

    unless recipe_food.recipe.user == current_user
      flash[:alert] =
        'You can not delete the ingredient that you did not added unless you are pro hacker'
      return redirect_to recipes_path
    end

    if recipe_food.destroy
      flash[:notice] = 'Ingredient was successfully deleted.'
    else
      flash[:alert] = 'Ingredient deleing failed. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
