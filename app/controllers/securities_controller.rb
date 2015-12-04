class SecuritiesController < ApplicationController
  def new
    @security = Security.new
  end

  def create
    symbol = params[:security][:symbol]
    @quote = StockQuote::Stock.quote(symbol)
    
    history = Securities::Stock.new(:symbol => symbol, :start_date => 60.day.ago.to_s)
    indicator = Indicators::Data.new(history.output)
    @sma = indicator.calc(:type => :sma, :params => 5).output.last
    @bbs = indicator.calc(:type => :bb, :params => [15, 3]).output.last
    @macd = indicator.calc(:type => :macd, :params => [12, 26, 9]).output.last
    @rsi = indicator.calc(:type => :rsi, :params => 29).output.last
    @sto = indicator.calc(:type => :sto, :params => [14, 3, 5]).output.last
  end

  # def show
  #   @quote = StockQuote::Stock.quote(params[:security][:name])
  # end

    

  #   @my_stocks = Securities::Stock.new(:symbol => 'SPY', :start_date => 2.day.ago.to_s)
  #   @sp = Securities::Stock.new(:symbol => '^GSPC', :start_date => 2.day.ago.to_s)

  #   @my_lookup = Securities::Lookup.new('SPY')

  #   @my_data = Indicators::Data.new(Securities::Stock.new(:symbol => 'AAPL', 
  #     :start_date => '2015-10-01', :end_date => '2015-11-09').output)


  #   @sp500 = StockQuote::Stock.quote("^GSPC")

  #   @goog = StockQuote::Stock.quote("GOOG")
  # end

end
