class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  acts_as_paranoid column: :is_unregistered


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :last_name_kanji, :first_name_kanji, :last_name_kana, :first_name_kana, :zip_code, :address, :phone_number, presence: true

  has_many :cart_items
  has_many :orders
  has_many :addresses
  
end
