class Address < ApplicationRecord
    belongs_to :end_user

    def shipping_information
        "#{self.zip_code} #{self.address} #{self.recipient_name}"
    end
end
