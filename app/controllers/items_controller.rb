class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :check_authorization, only: [:edit, :update]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました' # 保存成功時の処理
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def check_authorization
    redirect_to root_path unless current_user == @item.user
  end

  def update
    if @item.update(item_params) # 編集内容を更新
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category_id, :price, :info, :state_id, :fee_id, :time_to_delivery_id,
                                 :prefecture_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_authorization
    redirect_to root_path unless current_user == @item.user
  end
end
