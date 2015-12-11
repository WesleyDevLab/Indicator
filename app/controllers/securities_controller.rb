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

    @sup_resist = indicator.get_sup_resist(symbol, 120, 10, 1)
  end
end
