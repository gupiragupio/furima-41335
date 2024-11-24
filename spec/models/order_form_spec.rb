require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '購入機能のバリデーション' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)

      puts @user.inspect
      puts @item.inspect
      puts @order_form.inspect
    end

    context '購入が成功する場合' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入が失敗する場合' do
      it '郵便番号が空だと購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が未選択（1）だと購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @order_form.street = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では購入できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上では購入できない' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が半角数字でないと購入できない' do
        @order_form.phone_number = '１２３４５６７８９０'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'トークンが空では購入できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
