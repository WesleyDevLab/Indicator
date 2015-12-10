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

  def get_macd(indicators, fast_period, slow_period, signal_line)
    @macd = indicators.calc(:type => :macd, :params => [fast_period, slow_period, signal_line]).output.last
  end
  
  def get_rsi(indicators, period)
    @rsi = indicators.calc(:type => :rsi, :params => period).output.last
  end
   
  def get_sto(indicators, lookback, slow_k, d_ma) 
    @sto = indicators.calc(:type => :sto, :params => [lookback, slow_k, d_ma]).output.last
  end
end