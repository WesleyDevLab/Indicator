class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.boolean :bullish
      t.string  :underlying
      t.boolean :call
      t.integer :short_strike_price
      t.integer :long_strike_price
      t.date    :expiration

      t.integer :quantity
      t.float   :open_price
      t.float   :close_price

      t.integer :portfolio_id
      t.timestamps null: false
    end
  end
end
