class Security < ActiveRecord::Base
  
  def get_quote(symbol)
    StockQuote::Stock.quote(symbol)
  end

  def get_history(symbol, days)
    Securities::Stock.new(:symbol => symbol, :start_date => days.day.ago.to_s)
  end

  def get_indicators(history)
    Indicators::Data.new(history.output)
  end
end
