class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_in_stock: true) 
    @genres = Genre.where(is_activated: true)
  end

  def show
    @item = Item.find(params[:id])
    @new_cart_item = CartItem.new()
    @genres = Genre.where(is_activated: true)
  end
end
