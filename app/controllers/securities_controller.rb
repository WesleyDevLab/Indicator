class SecuritiesController < ApplicationController
  def new
    @security = Security.new
  end

  def create
    security = Security.new
    indicator = Indicator.new
    symbol = params[:symbol]
    @quote = security.get_quote(symbol)
    
    history = security.get_history(symbol, 60)

    indicators = security.get_indicators(history)
    @sma = indicator.get_ema(indicators, 5)
    @bb = indicator.get_bb(indicators, 15, 3)
    @macd = indicator.get_macd(indicators, 12, 26, 9)
    @rsi = indicator.get_rsi(indicators, 29)
    @sto = indicator.get_sto(indicators, 14, 3, 5)
  end

  def support_resistance

    # Get historical quotes
    history_arr = Securities::Stock.new(:symbol => "goog", :start_date => 120.day.ago.to_s)

    # Get the prices into one array
    price_arr = []
    history_arr.output.each do |quote|
      price_arr.push(quote[:close].to_f)
    end

    # Break timeseries into segments of N prices
    price_segment_arr = []
    price_arr.each_slice(10) {|price| price_segment_arr.push(price)}

    # Find min of each segments
    price_min_arr = []
    price_segment_arr.each do |segment|
      price_min_arr.push(segment.min)
    end
    price_min = price_min_arr.min

    # 
    price_support_arr = []
    price_support_arr.push(price_min)
    price_min_arr.each do |price|
      if (price / price_min - 1).abs * 100 < 3
        price_support_arr.push(price)
      end
    end

    price_support_arr.sum / price_support_arr.size

  end
end
