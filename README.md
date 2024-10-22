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

| Column             | Type      | Options                  |
| ------------------ | ------    | -----------              |
| item_name          | string    | NOT NULL                 |
| category           | string    | NOT NULL                 |
| price              | decimal   | NOT NULL                 |
| user_id            | references| NOT NULL, FOREIGN KEY制約 |
| info               | text      | NOT NULL                 |
| state              | integer   | NOT NULL                 |
| fee                | decimal   | NOT NULL                 |
| days               | integer   | NOT NULL                 |



### Association

belongs_to  :user
has_one :order_log, dependent: :destroy

## order_logsテーブル

| Column             | Type      | Options         |
| ------------------ | ------    | -----------     |
| user_id            | references| NOT NULL,外部キー|
| item_id            | references| NOT NULL,外部キー|

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses テーブル

| Column             | Type       | Options                           |
| ------------------ | ------     | -----------                       |
| order_log_id       |references  | NOT NULL,FOREIGN KEY制約           |
| street_name        | string     | NOT NULL                          |
| building_name      | string     |                                   |
| city               | string     | NOT NULL                          |
| telephone          | string     | NOT NULL                          |


### Association
belongs_to :order_log