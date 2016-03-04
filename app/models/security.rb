class Security < ActiveRecord::Base
  
  def get_stock_info(symbol)
    StockQuote::Stock.quote(symbol)
  end

  def get_price_history(symbol, days)
    Securities::Stock.new(:symbol => symbol, :start_date => days.day.ago.to_s)
  end

  def get_chart_data(data)
    chart_data = []
    data.output.each do |price|
      chart_data.push([DateTime.parse(price[:date]).strftime('%Q').to_i, price[:adj_close].to_f])
    end
    return chart_data
  end

  def get_indicators(history)
    Indicators::Data.new(history.output)
  end
end
