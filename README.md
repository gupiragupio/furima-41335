# テーブル設計

## users テーブル

| Column             | Type   | Options             |
| ------------------ | ------ | -----------         |
| nickname           | string | null: false             |
| email              | string | null: false,unique: true|
| encrypted_password | string | null: false             |
| first_name         | string | null: false             |
| last_name          | string | null: false             |
| first_name_kana    | string | null: false             |
| last_name_kana     | string | null: false             |
| birth_date         | date   | null: false             |


### Association

has_many :items
has_many :order_logs


##  itemsテーブル

| Column                              | Type       | Options                     |
| ------------------                  | ------     | -----------                 |
| item_name                           | string     | null: false                 |
| category_id                         | integer    | null: false                 |
| price                               | integer    | null: false                 |
| user                                | references | null: false, foreign_key: true  |
| info                                | text       | null: false                 |
| state_id                            | integer    | null: false                 |
| fee_id                              | integer    | null: false                 |
| time_to_delivery_id                 | integer    | null: false                 |
| city_id                             | integer    | null: false                 |
| prefecture _id                      | integer    | null: false                 |
 

### Association

belongs_to  :user
has_one :order_log

## order_logsテーブル

| Column             | Type      | Options         |
| ------------------ | ------    | -----------     |
| user               | references    | null: false, foreign_key: true|
| item               | references    | null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses テーブル

| Column             | Type       | Options                           |
| ------------------ | ------     | -----------                       |
| order_log          |references  | null: false, foreign_key: true          |
| street_name        | string     | null: false                          |
| building_name      | string     |                                 |
| city               | string     | null: false                          |
| telephone          | string     | null: false                         |
| postal_code        | string     | null: false                          |




### Association
belongs_to :order_log