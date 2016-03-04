class SecuritiesController < ApplicationController

  def new
    @security = Security.new
  end

  def create
    security = Security.new
    indicator = Indicator.new
    symbol = params[:symbol]

    @stock = security.get_stock_info(symbol) # Get stock's company data
    price_history = security.get_price_history(symbol, 60) # Get historical prices for 60 periods
    indicators = security.get_indicators(price_history) # Calculate indicator values
    
    # Pass data to JavaScript
    gon.prices = security.get_chart_data(price_history)
    gon.symbol = symbol
    gon.title = "#{@stock.name} (#{symbol})"

    @sma = indicator.get_ema(indicators, 5)
    @bb = indicator.get_bb(indicators, 15, 3)
    @macd = indicator.get_macd(indicators, 12, 26, 9)
    @rsi = indicator.get_rsi(indicators, 29)
    @sto = indicator.get_sto(indicators, 14, 3, 5)

    @sup_resist = indicator.get_sup_resist(symbol, 100, 15, 1.3)
  end
end
