class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new; end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create; end

  def edit; end

  def update; end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Your recipe has been successfully deleted'
  end
end
