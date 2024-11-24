class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_authorization

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    if order_params[:token].blank?
      flash.now[:alert] = 'カード情報を入力してください'
      render :index, status: :unprocessable_entity
      return
    end

    if @order.valid?
      begin
        pay_item
        @order.save
        redirect_to root_path, notice: '購入が完了しました。'
      rescue Payjp::PayjpError => e
        Rails.logger.error("PayjpError: #{e.message}")
        flash.now[:alert] = '決済処理に失敗しました。もう一度お試しください。'
        render :index, status: :unprocessable_entity
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_authorization
    if current_user == @item.user
      redirect_to root_path, alert: '自分の商品は購入できません。'
    elsif @item.order_log.present?
      redirect_to root_path, alert: 'この商品はすでに購入されています。'
    end
  end

  def order_params
    params.require(:order_form).permit(
      :postal_code, :prefecture_id, :city, :street, :building, :phone_number
    ).merge(
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
