class Address < ApplicationRecord
  belongs_to :order_log
end

class OrderLog < ApplicationRecord
  has_one :address
end
