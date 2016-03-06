class Trade < ActiveRecord::Base
  belongs_to :user

  def get_table_data(trades)
    table_trades = []
    trades.each do |trade|
      table_trades.push([trade.underlying, trade.expiration.to_s, 
        trade.option_type, trade.short_strike_price, trade.long_strike_price])
    end
    return table_trades
  end
end