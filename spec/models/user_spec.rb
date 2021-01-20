require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー登録ができる時' do
      it 'ニックネームとメールアドレス、パスワードとパスワード（確認用）、ユーザー本名とユーザー本名（フリガナ）、誕生日が存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'パスワードは、半角英数混合で6文字以上であれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end

      it 'ユーザー本名は、全角（漢字、ひらがな、カタカナ）であれば登録できること' do
        @user.first_name = '田中'
        @user.last_name = '太郎'
        expect(@user).to be_valid
      end

      it 'ユーザー本名のフリガナは、全角カタカナであれば登録できること' do
        @user.first_name_kana = 'タナカ'
        @user.last_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録ができない時' do
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含んでないと登録できないこと' do
        @user.email = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードは、5文字以下では登録できないこと' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
      end

      it 'パスワードは英語のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
      end

      it 'パスワードは全角では登録できないこと' do
        @user.password = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
      end

      it 'パスワード（確認用）が空では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank", 'Password confirmation is invalid')
      end

      it 'パスワードとパスワード（確認用）が不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名は、苗字が空では登録できないこと' do
        @user.first_name = '田中'
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name Full-width characters')
      end

      it 'ユーザー本名は、名前が空では登録できないこと' do
        @user.first_name = nil
        @user.last_name = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name Full-width characters')
      end

      it 'ユーザー本名は、全角（漢字、ひらがな、カタカナ）以外では登録できないこと' do
        @user.first_name = 'tanaka'
        @user.last_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters', 'Last name Full-width characters')
      end

      it 'ユーザー本名のフリガナは、名字が空では登録できないこと' do
        @user.first_name_kana = nil
        @user.last_name_kana = 'タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank",
                                                      'First name kana Full-width katakana characters')
      end

      it 'ユーザー本名のフリガナは、名前が空では登録できないこと' do
        @user.first_name_kana = 'タナカ'
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank",
                                                      'Last name kana Full-width katakana characters')
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）以外では登録できないこと' do
        @user.first_name_kana = 'たなか'
        @user.last_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters',
                                                      'Last name kana Full-width katakana characters')
      end

      it '生年月日が空では登録できないこと' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
