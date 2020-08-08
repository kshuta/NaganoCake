class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all()
    @genres = Genre.where(is_activated: true)
  end

  def new
    @new_item = Item.new()
    @genres = Genre.where(is_activated: true)
  end

  def show
  end

  def edit
  end

  def create
    new_item = Item.new(item_params)
    new_item.is_in_stock = params[:is_in_stock]
    if new_item.save
      redirect_to admin_item_path(new_item)
    else 
      @new_item = new_item
      @genres = Genre.where(is_activated: true)
      render :new
    end
  end

  def search
    @items = Item.search(params[:search])
    @genres = Genre.where(is_activated: true)
    render :index
  end

  private
  def item_params 
    params.require(:item).permit(:name, :description, :genre_id, :untaxed_price, :is_in_stock, :image)
  end
end
