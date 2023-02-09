class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    @current_user = current_user
  end

  def new
    @recipe = Recipe.new
  end

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
