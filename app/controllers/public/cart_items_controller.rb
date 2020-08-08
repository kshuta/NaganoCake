class Public::CartItemsController < ApplicationController
    def index
        @cart_items = CartItem.where(end_user_id: current_end_user.id)
    end
    
    def create
        if !current_end_user
            redirect_to new_end_user_session_path
        else
            if CartItem.find_by(end_user_id: current_end_user.id, item_id: cart_item_params[:item_id])
                puts("if")
                cart_item = CartItem.find_by(end_user_id: current_end_user.id, item_id: cart_item_params[:item_id])
                cart_item[:amount] = (cart_item[:amount] + cart_item_params[:amount].to_i).to_s
                cart_item.update(item_id: cart_item_params[:item_id], amount: cart_item[:amount])
                redirect_to cart_items_path
            else  
                puts ("else")
                cart_item = current_end_user.cart_items.new(cart_item_params)
                cart_item.save
                redirect_to cart_items_path
            end 
        end
    end

    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(cart_item_params)
        redirect_to cart_items_path
    end

    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy 
        redirect_to cart_items_path 
    end

    def destroy_all
        CartItem.delete_all
        redirect_to cart_items_path
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id)
    end    
end
