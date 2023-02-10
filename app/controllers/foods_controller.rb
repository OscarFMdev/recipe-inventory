class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.includes(:user)
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.foods.new(food_params)

    if food.save
      redirect_to foods_path, notice: 'New Food was successfully added.'
    else
      flash[:alert] = 'New Food adding Failed. Please try again.'
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])
    if @food.update(food_params)
      redirect_to foods_path, notice: 'Food was successfully updated.'
    else
      flash[:alert] = 'Food updating Failed. Please try again.'
    end
  end

  def destroy
    food = Food.find(params[:id])

    unless food.user == current_user
      return flash[:alert] =
               'You do not have access to delete the Food belongs to other Users.'
    end

    if food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Food deleting Failed. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def general
    @foods = current_user.foods.includes([:recipe_foods])
    current_user.recipes.map do |recipe|
      recipe.recipe_foods.map do |recipe_food|
        food = recipe_food.food
        test = @foods.select { |f| f.name == food.name }[0]
        test.quantity = test.quantity - recipe_food.quantity
      end
    end
    @foods = @foods.select { |f| f.quantity.negative? }
    @foods.each { |f| f.quantity *= -1 }
    @total = 0
    @foods.each do |food|
      @total += (food.price * food.quantity)
    end
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement, :price)
  end
end
