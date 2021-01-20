require 'rails_helper'

RSpec.describe User, type: :model do

  describe "ユーザー新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    it "ニックネームが必須であること" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "メールアドレスが必須であること" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "メールアドレスが一意性であること" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "メールアドレスは、@を含む必要性があること" do
      @user.email = "abcdefg"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードは、６文字以上での入力が必須であること" do
      @user.password ="123ab"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードは、半角英数混合での入力が必須であること" do
      @user.password = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
    end

    it "パスワードは確認用を含めて2回入力すること" do
      @user.password = "123abc"
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it "パスワードとパスワード（確認用）、値の一意が必須であること" do
      @user.password = "123abc"
      @user.password_confirmation = "123abcd"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "ユーザー本名は、苗字と名前がそれぞれ必須であること" do
      @user.first_name = "田中"
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name Full-width characters")
    end

    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
      @user.first_name = "tanaka"
      @user.last_name = "taro"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters", "Last name Full-width characters")
    end

    it "ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること" do
      @user.first_name_kana = "タナカ"
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana Full-width katakana characters")
    end

    it "ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること" do
      @user.first_name_kana = "たなか"
      @user.last_name_kana = "たろう"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters", "Last name kana Full-width katakana characters")
    end

    it "生年月日が必須であること" do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
