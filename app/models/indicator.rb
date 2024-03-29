class Indicator < ActiveRecord::Base

  def set_indicator_data(history)
    Indicators::Data.new(history.output)
  end

  def get_simple_moving_avg(indicator_data, period)
    indicator_data.calc(:type => :sma, :params => period).output.last
  end

  def get_exp_moving_avg(indicator_data, period)
    indicator_data.calc(:type => :ema, :params => period).output.last
  end

  def get_bollinger_bands(indicator_data, period, multiplier)
    indicator_data.calc(:type => :bb, :params => [period, multiplier]).output.last
  end

  def get_macd(indicator_data, fast, slow, signal)
    @macd = indicator_data.calc(:type => :macd, :params => [fast, slow, signal]).output.last
  end
  
  def get_rsi(indicator_data, period)
    @rsi = indicator_data.calc(:type => :rsi, :params => period).output.last
  end
   
  def get_stochastic(indicator_data, lookback, slow_k, d_ma) 
    @sto = indicator_data.calc(:type => :sto, :params => [lookback, slow_k, d_ma]).output.last
  end

  # http://stackoverflow.com/questions/8587047/support-resistance-algorithm-technical-analysis
  def get_support_resistance(symbol, period, num, pct)
    quote = Quote.new

    # Get historical data
    history_arr = quote.get_price_history(symbol, period)

    # Extract the prices from the historical quotes
    price_arr = []
    history_arr.output.each do |quote|
      price_arr.push(quote[:close].to_f)
    end

    # Break the time series of prices into segments of num
    segment_arr = []
    price_arr.each_slice(num) {|price| segment_arr.push(price)}

    # Find min and max price of each segments
    segment_minmax_arr = []
    segment_arr.each do |segment|
      segment_minmax_arr.push(segment.min)
      segment_minmax_arr.push(segment.max)
    end

    # Loop to calculate all price levels and put into a hash
    levels = Hash.new
    until segment_minmax_arr.count == 0 do

      # Each iteration, take the min of all mix/max prices as reference
      # Doesn't matter if using for min or max
      price_min = segment_minmax_arr.min

      # Check other prices within a pct of it
      support_arr = []
      support_arr.push(price_min)
      segment_minmax_arr.delete(price_min)

      segment_minmax_arr.each do |price|
        if (price / price_min - 1).abs * 100 < pct
          support_arr.push(price)
          segment_minmax_arr.delete(price)
        end
      end

      # support price and strength
      price = (support_arr.sum / support_arr.size).round(2)
      levels[price] = support_arr.size
    end

    levels
  end
end

