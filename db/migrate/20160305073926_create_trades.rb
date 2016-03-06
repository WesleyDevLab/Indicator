class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.boolean :bullish
      t.string  :underlying
      t.string  :option_type
      t.integer :short_strike_price
      t.integer :long_strike_price
      t.date    :expiration

      t.integer :quantity
      t.float   :open_price
      t.float   :close_price

      t.integer :user_id
      t.timestamps null: false
    end
  end
end
