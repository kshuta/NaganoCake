class OrderDetail < ApplicationRecord
    belongs_to :order 
    belongs_to :item

    enum production_status: [:unavailable, :pending_production, :producing, :produced]
end
