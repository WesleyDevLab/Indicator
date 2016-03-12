class QuotesController < ApplicationController

  def new
    @quote = Quote.new
  end

  def create
    quote = Quote.new
    indicator = Indicator.new
    symbol = params[:symbol]

    # Call Yahoo finance API
    begin
      @stock = quote.get_stock_info(symbol) # Get stock's company data
      price_history = quote.get_price_history(symbol, 720) # Get historical prices for 60 periods

    rescue
      alert = "#{symbol} not found"
      redirect home_path
    end

    # Pass data to JavaScript
    gon.prices = quote.get_chart_data(price_history)
    gon.symbol = symbol.upcase!
    gon.title = "#{@stock.name} (#{symbol})"

    # Calculate indicators
    indicator_data = indicator.set_indicator_data(price_history)
    @sma = indicator.get_simple_moving_avg(indicator_data, 5)
    @bb = indicator.get_bollinger_bands(indicator_data, 15, 3)
    @macd = indicator.get_macd(indicator_data, 12, 26, 9)
    @rsi = indicator.get_rsi(indicator_data, 29)
    @sto = indicator.get_stochastic(indicator_data, 14, 3, 5)
    @sup_resist = indicator.get_support_resistance(symbol, 100, 15, 1.3)
  end
end
