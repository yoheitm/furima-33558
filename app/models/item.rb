class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :user
  belongs_to :area
  belongs_to :category
  belongs_to :ship_base
  belongs_to :ship_date
  belongs_to :state
  #has_one    :purchase

  validates :name, :info, :image, presence: true
  validates :area_id, :category_id, :ship_base_id, :ship_date_id,
            :state_id, numericality: { other_than: 1 }
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ },
                    length: { minimum: 3, maximum: 7 }, numericality: {
                      only_integer: true, greater_than: 299, less_than: 10_000_000
                    }
end
