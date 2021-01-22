require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品新規登録' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('app/assets/images/item-sample.png')
    end

    context '商品登録ができる時' do
      it '画像と商品名と商品の説明、カテゴリーと商品の状態、配送者の負担と発送元の地域、発送までの日数と販売価格が存在すれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '商品登録ができない時' do
      it '画像が空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では登録できないこと' do
        @item.info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'カテゴリーが空では登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it '商品の状態が空では登録できないこと' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('State must be other than 1')
      end

      it '配送者の負担が空では登録できないこと' do
        @item.ship_base_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship base must be other than 1')
      end

      it '発送元の地域が空では登録できないこと' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Area must be other than 1')
      end

      it '発送までの日数が空では登録できないこと' do
        @item.ship_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship date must be other than 1')
      end

      it '販売価格が空では登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が¥299以下では登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end

      it '販売価格が¥10,000,000以上では登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end

      it '販売価格は全角文字では登録できないこと' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角英数字混合では登録できないこと' do
        @item.price = '123abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角英語だけでは登録できないこと' do
        @item.price = 'abcd'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
