# テーブル設計

## users テーブル

| Column             | Type   | Options             |
| ------------------ | ------ | -----------         |
| nickname           | string | NOT NULL            |
| email              | string | null: false,unique: true|
| encrypted_password | string | NOT NULL            |
| first_name         | string | NOT NULL            |
| last_name          | string | NOT NULL            |
| first_name_kana    | string | NOT NULL            |
| last_name_kana     | string | NOT NULL            |
| birth_date         | date   | NOT NULL            |


### Association

has_many :items
has_many :order_logs


##  itemsテーブル

| Column             | Type      | Options                     |
| ------------------ | ------    | -----------                 |
| item_name          | string    | null: false                 |
| category           | integer   | null: false                 |
| price              | integer   | null: false                 |
| user               | references    | null: false, foreign_key: true  |
| info               | text      | null: false                 |
| state              | integer   | null: false                 |
| fee                | integer   | null: false                 |
| dtime              | integer   | null: false                 |



### Association

belongs_to  :user
has_one :order_log, dependent: :destroy

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
| building_name      | string     | null: false                                 |
| city               | string     | null: false                          |
| telephone          | string     | null: false                         |
| card_number        | VARCHAR(19)| null: false                          |
| cvv                | VARCHAR(4) | null: false                                 |
| postal_code        | VARCHAR(10)| null: false                          |
| card_expiry        | VARCHAR(5) | null: false                         |



### Association
belongs_to :order_log