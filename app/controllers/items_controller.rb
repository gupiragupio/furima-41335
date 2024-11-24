class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_authorization, only: [:edit, :update, :destroy]
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
  end

  def edit
  end

  def update
    if @item.update(item_params) # 編集内容を更新
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品を削除しました'
    else
      redirect_to item_path(@item), alert: '商品の削除に失敗しました'
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
    # 出品者ではない、または売却済みの場合はトップページにリダイレクト
    return unless current_user != @item.user || @item.sold?

    redirect_to root_path, alert: '編集権限がありません。'
  end
end
