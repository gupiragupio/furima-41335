class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_authorization

  def index
    redirect_to root_path, alert: 'この商品はすでに購入されています。' if @item.order_log.present?
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_authorization
    redirect_to root_path if current_user == @item.user || @item.order_log.present?
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :street, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
