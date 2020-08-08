class Public::OrdersController < ApplicationController
  def index
  end

  def new
    if CartItem.where(end_user_id: current_end_user.id).empty?
      redirect_to cart_items_path, notice: "カートの中身が空の状態では情報入力に進めません"
    end
    @new_order = Order.new()
    @addresses = Address.where(end_user_id: current_end_user.id)
  end

  def show
  end

  def create
    ## creating new Order object to save to database.
    modified_params = order_params.except(:existing_address, :payment_method)
    new_order = current_end_user.orders.new(modified_params)
    new_order.payment_method = order_params[:payment_method].to_i
    new_order.preparation_status = 0;
    new_order.shipping_fee = 800;
    new_order.save
    
    ## loop to create order_detail
    cart_items = CartItem.where(end_user_id: current_end_user.id)
    taxed_prices = []
    cart_items.each do |cart_item|
      new_order_detail = OrderDetail.new()
      new_order_detail.order_id = new_order.id
      new_order_detail.item_id = cart_item.item_id
      new_order_detail.amount = cart_item.amount
      new_order_detail.taxed_price = (cart_item.item.untaxed_price * 1.08).round(0)
      taxed_prices.push(new_order_detail.taxed_price*cart_item.amount)
      new_order_detail.production_status = 0
      if new_order_detail.save
      else
        new_order_detail.errors.messages.each do |message|
          puts(message)
        end
      end
    end
    ## deleting cart-item after creating order_detail
    cart_items.delete_all

    ## assiging total price for new_order object and saving it.
    new_order.update(total_price: taxed_prices.sum())

    
    redirect_to order_done_path
  end
  
  
  def confirm
    ## If statement to determine shipping address 
    if params[:address_flag] == "0"
      zip_code = current_end_user.zip_code 
      address = current_end_user.address 
      recipient_name = "#{current_end_user.last_name_kanji}#{current_end_user.first_name_kanji}"
    elsif params[:address_flag] == "1"
      full_address = Address.find_by(end_user_id: current_user.id, id: order_params[:existing_address])
      zip_code = full_address.zip_code 
      address = full_address.address 
      recipient_name = full_address.recipient_name
    else  
      if order_params[:zip_code].empty? || order_params[:address].empty? || order_params[:recipient_name].empty?
        @new_order = Order.new()
        @addresses = Address.where(end_user_id: current_end_user.id)
        redirect_to new_order_path, notice: "新しい郵便番号、住所、宛名を全て記入してください"
      else
        zip_code = order_params[:zip_code]
        address = order_params[:address]
        recipient_name = order_params[:recipient_name]
      end
    end 
    
    @new_order = current_end_user.orders.new(preparation_status: 0, recipient_name: recipient_name, zip_code: zip_code, address: address, payment_method: params[:payment_method].to_i, shipping_fee: 800)

    @cart_items = CartItem.where(end_user_id: current_end_user.id)
  end

  def done
  end

  private

  def order_params 
    params.require(:order).permit(:zip_code, :address, :recipient_name, :payment_method, :existing_address)
  end
  
end
