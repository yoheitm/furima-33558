## users　テーブル

| Column                    | Type     | Options                       |
| ------------------------- | -------- | ----------------------------- |
| nickname                  | string   | null: false                   |
| email                     | string   | null: false, uniqueness: true |
| encrypted_password        | string   | null: false                   |
| first_name                | string   | null: false                   |
| last_name                 | string   | null: false                   |
| first_name_kana           | string   | null: false                   |
| last_name_kana            | string   | null: false                   |
| birth_date                | date     | null: false                   |

### Association

- has_many :items
- has_many :comments
- has_one  :purchase

## items テーブル

| Column               | Type       | Options           |
| -------------------- | ---------- | ----------------- |
| name                 | string     | null: false       |
| info                 | text       | null: false       |
| category_id          | integer    | null: false       |
| state_id             | integer    | null: false       |
| ship_base_id         | integer    | null: false       |
| area_id              | integer    | null: false       |
| ship_date_id         | integer    | null: false       |
| price                | integer    | null: false       |
| user                 | references | foreign_key: true |

### Association

- belongs_to    :user
- has_one       :purchase
- has_many      :comments

## comments テーブル

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| text       | text       | null: false       |
| user       | references | foreign_key: true |
| item       | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## address

| Column           | Type       | Option            |
| ---------------- | ---------- | ----------------- |
| postcode         | string     | null: false       |
| area_id          | integer    | null: false       |
| city             | string     | null: false       |
| block            | string     | null: false       |
| building         | string     |                   |
| phone_number     | string     | null: false       |
| purchase         | references | foreign_key: true |

### Association

- belongs_to  :purchase

## purchases

| Column     | Type       | Option            |
| ---------- | ---------- | ----------------- |
| user       | references | foreign_key: true |
| item       | references | foreign_key: true |

### Association

- belongs_to   :user
- belongs_to   :item
- has_one      :address
