class OrderLog < ApplicationRecord
  belongs_to :user
  belongs_to :item
end

class Item < ApplicationRecord
  has_one :order_log
end

class User < ApplicationRecord
  has_many :order_logs
end
