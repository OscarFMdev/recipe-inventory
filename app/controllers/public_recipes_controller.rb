class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.destroy
        format.html { redirect_to public_recipes_path, notice: 'Public recipe was deleted successfully.' }
      else
        format.html { render :new, alert: 'An error has occurred while deleting the recipt, try again' }
      end
    end
  end
end
