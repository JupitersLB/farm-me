class BasketItemsController < ApplicationController
  def create
    @basket_item = BasketItem.new(basket_item_params)
    @basket = Basket.find(params[:basket_id])
    @basket_item.basket = @basket
    if @basket_item.save
      @basket_item = BasketItem.new
      redirect_to basket_path(@basket)
    else
      render './basket/show'
    end
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:description, :ingredient_id)
  end
end