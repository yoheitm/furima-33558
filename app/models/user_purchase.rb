class UserPurchase
  include ActiveModel::Model
  attr_accessor :postcode, :area_id, :city, :block, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, format: { with: /\A[0-9]{,11}\z/, message: 'is invalid. Input half-width characters.' }
    validates :city
    validates :block
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :area_id, numericality: { other_than: 1 }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, area_id: area_id, city: city, block: block, building: building,
                   phone_number: phone_number, purchase_id: purchase.id)
  end
end
