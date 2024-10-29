class Item < ApplicationRecord
  belongs_to :user
  has_one :order_log
  has_one_attached :image
end
