class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :user
  belongs_to :area
  belongs_to :category
  belongs_to :ship_base
  belongs_to :ship_date
  belongs_to :state

  validates :name, :info, :price, presence: true
  validates :area_id, :category_id, :ship_base_id,
    :ship_date_id, :state_id, numericality: { other_than: 1 }
end
