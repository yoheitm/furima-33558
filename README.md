## users　テーブル

| Column     | Type     | Options     |
| ---------- | -------- | ----------- |
| nickname   | string   | null: false |
| email      | string   | null: false |
| password   | password | null: false |
| first_name | string   | null: false |
| last_name  | string   | null: false |
| birthday   | integer  | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :credit_address

## items テーブル

| Column            | Type       | Options
| ----------------- | ---------- | -------
| name              | string     | null: false
| describe          | text       | null: false
| category          | string     | null: false
| state             | string     | null: false
| shipping_charges  | string     | null: false
| shipping_area     | string     | null: false
| days_to_ship      | string     | null: false
| price             | integer    | null: false
| user_id           | references | foreign_key: true

### Association

- has_many   :comments
- has_one    :credit_address
- belongs_to :user

## comments テーブル

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| text       | text       | null: false       |
| user_id    | references | foreign_key: true |
| product_id | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## credit_address

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| credit_id  | references | foreign_key: true |
| address_id | references | foreign_key: true |
| user_id    | references | foreign_key: true |
| product_id | references | foreign_key: true |

### Association

