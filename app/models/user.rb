class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  #has_many :purchases

  with_options presence: true do
    validates :nickname
    with_options format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/ } do
      validates :password
      validates :password_confirmation
    end
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' } do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :birth_date
  end
end
