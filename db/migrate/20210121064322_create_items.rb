class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name          ,null: false
      t.text       :info          ,null: false
      t.integer    :category_id   ,null: false
      t.integer    :state_id      ,null: false
      t.integer    :ship_base_id  ,null: false
      t.integer    :area_id       ,null: false
      t.integer    :ship_date_id  ,null: false
      t.integer    :price         ,null: false
      t.references :user          ,null: false
      t.timestamps
    end
  end
end
