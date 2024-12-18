class Item < ApplicationRecord
  belongs_to :user
  # has_one :order_log
  has_one_attached :image
  before_destroy :purge_image
  has_one :order_log

  validates :item_name, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, message: 'is not a number' }
  validates_numericality_of :price, greater_than_or_equal_to: 300, message: 'must be greater than or equal to 300'
  validates_numericality_of :price, less_than_or_equal_to: 9_999_999, message: 'must be less than or equal to 9999999'
  validates :info, presence: true
  validates :state_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :time_to_delivery_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :image, presence: { message: "can't be blank" }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :state
  belongs_to_active_hash :fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :time_to_delivery

  def sold?
    order_log.present?
  end

  private

  def purge_image
    image.purge if image.attached?
  end
end
