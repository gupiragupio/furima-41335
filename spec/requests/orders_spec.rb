require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    allow(Payjp::Charge).to receive(:create).and_return(true) # PAY.JPモック化
  end

  describe 'GET #index' do
    context 'ログイン状態の場合' do
      it '販売中の商品購入ページに遷移できる' do
        sign_in @user
        get item_orders_path(@item)
        expect(response).to render_template(:index)
      end

      it '売却済みの商品購入ページに遷移しようとするとトップページに遷移する' do
        FactoryBot.create(:order_log, item: @item, user: @user)
        sign_in @user
        get item_orders_path(@item)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしていない場合' do
      it '商品購入ページに遷移しようとするとログインページにリダイレクトされる' do
        get item_orders_path(@item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context '正常系' do
      it '購入が成功するとトップページにリダイレクトされる' do
        sign_in @user
        post item_orders_path(@item), params: {
          order_form: FactoryBot.attributes_for(:order_form).merge(user_id: @user.id, item_id: @item.id, token: 'tok_test')
        }
        expect(response).to redirect_to(root_path)
      end
    end

    context '異常系' do
      it '不正な情報では購入ページを再表示する' do
        sign_in @user
        post item_orders_path(@item), params: {
          order_form: FactoryBot.attributes_for(:order_form).merge(token: '')
        }
        expect(response).to render_template(:index)
      end
    end
  end
end
