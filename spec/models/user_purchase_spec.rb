require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '購入情報の保存' do
    before do
      @user_purchase = FactoryBot.build(:user_purchase)
    end

    context '商品を購入できる時' do
      it '全ての値が正しく入力されていれば購入できること' do
        expect(@user_purchase).to be_valid
      end

      it '建物名が未入力でも購入できること' do
        @user_purchase.building = nil
        expect(@user_purchase).to be_valid
      end
    end

    context '商品を購入できない時' do
      it '郵便番号が空では購入できないこと' do
        @user_purchase.postcode = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号にハイフンが含まれていないと購入できないこと' do
        @user_purchase.postcode = 1_234_567
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号が全角数字では購入できないこと' do
        @user_purchase.postcode = '１２３４５６７'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号が半角英字では購入できないこと' do
        @user_purchase.postcode = 'abcdefg'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号が8文字以上では購入できないこと' do
        @user_purchase.postcode = 123 - 45_678
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号が6文字以下では購入できないこと' do
        @user_purchase.postcode = 123 - 456
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が空では購入できないこと' do
        @user_purchase.area_id = 1
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Area must be other than 1')
      end
      it '市区町村が空では購入できないこと' do
        @user_purchase.city = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では購入できないこと' do
        @user_purchase.block = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空では購入できないこと' do
        @user_purchase.phone_number = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンが含まれていると購入できないこと' do
        @user_purchase.phone_number = '123-4567-8910'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Phone number is invalid. Input half-width characters.')
      end
      it '電話番号が全角数字では購入できないこと' do
        @user_purchase.phone_number = '１２３４５６７８９１０'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Phone number is invalid. Input half-width characters.')
      end
      it '電話番号が半角英字では購入できないこと' do
        @user_purchase.phone_number = 'abcdefghijk'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Phone number is invalid. Input half-width characters.')
      end
      it '電話番号が12文字以上では購入できないこと' do
        @user_purchase.phone_number = 123_456_789_101
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include('Phone number is invalid. Input half-width characters.')
      end
      it 'tokenが空では購入できないこと' do
        @user_purchase.token = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
