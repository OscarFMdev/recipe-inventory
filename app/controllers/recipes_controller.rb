class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    recipe_test = Recipe.find(params[:id])
    unless recipe_test.user == current_user || recipe_test.public?
      flash[:alert] =
        'You do not have access to see details.'
      return redirect_to recipes_path
    end

    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.js
      else
        format.html { render :new, alert: 'An error has occurred while creating the recipt, try again' }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.destroy
        format.html { redirect_to recipes_path, notice: 'Recipe was deleted successfully.' }
      else
        format.html { render :new, alert: 'An error has occurred while deleting the recipt, try again' }
      end
    end
  end

  def public
    @totals = {}
    @public_recipes = Recipe.where(public: true).order('created_at DESC')
    @public_recipes.each do |pub|
      total = 0
      RecipeFood.where(recipe_id: pub.id).each do |rec_food|
        total += rec_food.quantity * rec_food.food.price
      end
      @totals[pub.name] = total
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
