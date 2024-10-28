class Item < ApplicationRecord
  belongs_to :user
  has_one :order_log
end
