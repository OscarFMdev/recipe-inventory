class FoodsController < ApplicationController
  def index
    @foods = Food.all
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

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement_unit, :price)
  end
end
