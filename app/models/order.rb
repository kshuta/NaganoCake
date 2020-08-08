class Order < ApplicationRecord
    belongs_to :end_user, -> { with_deleted }
    has_many :order_details

    Order.includes(:end_user).all

    enum preparation_status: [:pending_payment, :confirmed_payment, :producing, :shipping_prep, :shipped]
    
    enum payment_method: [:credit_card, :bank_transfer]

    def total_amount
        order_details = OrderDetail.where(order_id: self.id)
        amounts = []
        order_details.each do |detail|
            amounts.push(detail.amount)
        end
        return amounts.sum
    end

    def shipping_information
        "#{self.zip_code} #{self.address} #{self.recipient_name}"
    end
end
