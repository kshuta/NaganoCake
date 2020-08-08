class Admin::OrderDetailsController < ApplicationController
    def update 
        order_detail = OrderDetail.find(order_detail_params[:id])
        order_detail.update(production_status: order_detail_params[:production_status].to_i)
        
        ## production statusが制作中になったら、preparation statusが制作中になっていないか確認
        if order_detail.production_status == "producing"
            Order.find(order_detail.order_id).update(preparation_status: 2)
        end

        ## 全てのproduction statusが制作完了になったらpreparation status を発送準備中に更新する。
        if order_detail.production_status == "produced"
            all_done = true
            order_details = OrderDetail.where(order_id: order_detail.order_id)
            order_details.each do |order_detail|
                if order_detail.production_status != "produced"
                    all_done = false
                end
            end
            if all_done
                Order.find(order_detail.order_id).update(preparation_status: 3)
            end
        end

        redirect_to admin_order_path(order_detail.order_id)
    end

    private
    def order_detail_params 
        params.require(:order_detail).permit(:id, :production_status)
    end
end
