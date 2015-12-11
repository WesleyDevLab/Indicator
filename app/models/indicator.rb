class Indicator < ActiveRecord::Base

  def get_sma(indictors, period)
    indicators.calc(:type => :sma, :params => period).output.last
  end

  def get_ema(indicators, period)
    indicators.calc(:type => :ema, :params => period).output.last
  end

  def get_bb(indicators, period, multiplier)
    indicators.calc(:type => :bb, :params => [period, multiplier]).output.last
  end

  def get_macd(indicators, fast, slow, signal)
    @macd = indicators.calc(:type => :macd, :params => [fast, slow, signal]).output.last
  end
  
  def get_rsi(indicators, period)
    @rsi = indicators.calc(:type => :rsi, :params => period).output.last
  end
   
  def get_sto(indicators, lookback, slow_k, d_ma) 
    @sto = indicators.calc(:type => :sto, :params => [lookback, slow_k, d_ma]).output.last
  end

  ### Work in Progress
  def get_sup_resist(period, num, pct)
    security = Security.new

    # Get historical quotes
    history_arr = security.get_history(symbol, period)

    # Get the prices into one array
    price_arr = []
    history_arr.output.each do |quote|
      price_arr.push(quote[:close].to_f)
    end

    # Break timeseries into segments of N prices
    price_segment_arr = []
    price_arr.each_slice(num) {|price| price_segment_arr.push(price)}

    # Find min of each segments
    price_min_arr = []
    price_segment_arr.each do |segment|
      price_min_arr.push(segment.min)
    end
    price_min = price_min_arr.min

    # Support is the min price and prices within pct of it
    price_support_arr = []
    price_support_arr.push(price_min)
    price_min_arr.each do |price|
      if (price / price_min - 1).abs * 100 < pct
        price_support_arr.push(price)
      end
    end

    # support price and strength
    support =price_support_arr.sum / price_support_arr.size
    support_strength = price_support_arr.size
  end

end