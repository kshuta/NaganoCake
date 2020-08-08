class Admin::OrdersController < ApplicationController
    def index 
        @orders = Order.all.order(created_at: "DESC")
    end

    def show
        @order = Order.find(params[:id])
        @order_details = OrderDetail.where(order_id: @order.id)
    end

    def update
        order = Order.find(params[:id])  
        ## validation to make sure production_status for order_details only change when preparation_status changes from something else to "入金確認"
        if order.preparation_status != "confirmed_payment"
            order.update(preparation_status: order_param[:preparation_status].to_i)
            
            ## 入金確認になったら紐づくorder_detailの制作ステータスを全て制作待ちにする
            if order.preparation_status == "confirmed_payment"
                order_details = OrderDetail.where(order_id: order.id)
                order_details.each do |order_detail|
                    order_detail.update(production_status: 1)
                end
            end
        else 
            order.update(preparation_status: order_param[:preparation_status].to_i) 
        end


        redirect_to admin_order_path(order)
    end

    private
    def order_param 
        params.require(:order).permit(:preparation_status)
    end
end
