class Item < ApplicationRecord
  belongs_to :user
  has_one :order_log
  has_one_attached :image

  validates :item_name, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true
  validates :info, presence: true
  validates :state_id, presence: true
  validates :fee_id, presence: true
  validates :time_to_delivery_id, presence: true
  validates :prefecture_id, presence: true
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
end
