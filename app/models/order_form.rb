class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :user_id, :item_id, :token

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, :street, :phone_number, :user_id, :item_id, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  validates :token, presence: true

  def save
    order_log = OrderLog.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city, street: street, building: building,
      phone_number: phone_number, order_log_id: order_log.id
    )
  end
end
