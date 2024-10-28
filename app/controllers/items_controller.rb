class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました' # 保存成功時の処理
    else
      render :new # 保存失敗時の処理（出品ページに戻す）
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category_id, :price, :info, :state_id, :fee_id, :time_to_delivery_id,
                                 :prefecture_id).merge(user_id: current_user.id)
  end
end
