## users　テーブル

| Column          | Type     | Options     |
| --------------- | -------- | ----------- |
| nickname        | string   | null: false |
| email           | string   | null: false |
| password        | string   | null: false |
| first_name      | string   | null: false |
| last_name       | string   | null: false |
| first_name_kana | string   | null: false |
| last_name_kana  | string   | null: false |
| birth_date      | date     | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :buyers

## items テーブル

| Column                 | Type       | Options           |
| ---------------------- | ---------- | ----------------- |
| item_name              | string     | null: false       |
| item_info              | text       | null: false       |
| item_category          | string     | null: false       |
| item_state             | string     | null: false       |
| item_shipping_charges  | string     | null: false       |
| item_shipping_area     | date       | null: false       |
| item_days_to_ship      | string     | null: false       |
| item_price             | integer    | null: false       |
| user_id                | references | foreign_key: true |
| buyer_id               | references | foreign_key: true |

### Association

- has_many      :comments
- belongs_to    :buyer
- belongs_to    :user

## comments テーブル

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| text       | text       | null: false       |
| user_id    | references | foreign_key: true |
| item_id    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## address

| Column       | Type       | Option      |
| ------------ | ---------- | ----------- |
| postcode     | integer    | null: false |
| area         | date       | null: false |
| city         | string     | null: false |
| block        | string     | null: false |
| building     | string     |             |
| phone_number | integer    | null: false |

### Association

- has_many  :buyers

## buyers

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| user_id    | references | foreign_key: true |
| address_id | references | foreign_key: true |

### Association

- belongs_to   :user
- belongs_to   :address
- has_one      :item
