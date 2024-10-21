# テーブル設計

## users テーブル

| Column             | Type   | Options             |
| ------------------ | ------ | -----------         |
| nickname           | string | NOT NULL, ユニーク制約|
| email              | string | NOT NULL, ユニーク制約|
| encrypted_password | string | NOT NULL            |
| first_name         | string | NOT NULL            |
| last_name          | string | NOT NULL            |
| first_name_kana    | string | NOT NULL            |
| last_name_kana    | string | NOT NULL            |
| birth_date         | date   | NOT NULL            |


### Association

has_many :items
has_many :order_logs


##  itemsテーブル

| Column             | Type      | Options                  |
| ------------------ | ------    | -----------              |
| item_name          | string    | NOT NULL                 |
| category           | string    | NOT NULL                 |
| price              | integer   | NOT NULL                 |
| user_id            | references| NOT NULL, FOREIGN KEY制約 |


### Association

belongs_to  :user
has_many :order_logs, dependent: :destroy

## order_logsテーブル

| Column             | Type      | Options         |
| ------------------ | ------    | -----------     |
| user_id            | references| NOT NULL,外部キー|
| item_id            | references| NOT NULL,外部キー|
| message            | text      | NOT NULL,       |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses テーブル

| Column             | Type       | Options                           |
| ------------------ | ------     | -----------                       |
| order_log_id       |references  | NOT NULL,FOREIGN KEY制約           |
| address_line1      | string     | NOT NULL                          |
| address_line2      | string     |                                   |
| city               | string     | NOT NULL                          |
| state              | string     | NOT NULL                          |
| country            | string     | NOT NULL                          |


### Association
belongs_to :order_log