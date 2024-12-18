class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      t.string :item_name,              null: false
      t.integer  :category_id ,         null: false
      t.integer  :price ,               null: false
      t.references :user,               null: false, foreign_key: true
      t.text :info,                     null: false
      t.integer  :state_id ,            null: false
      t.integer  :fee_id,               null: false
      t.integer  :time_to_delivery_id , null: false
      t.integer  :prefecture_id,        null: false

      t.timestamps
    end
  end
end
