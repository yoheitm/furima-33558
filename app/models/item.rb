class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :user
  belongs_to :area
  belongs_to :category
  belongs_to :ship_base
  belongs_to :ship_date
  belongs_to :sate
end
