class SecuritiesController < ApplicationController
  def home
    @my_stocks = Securities::Stock.new(:symbol => 'SPY', :start_date => 2.day.ago.to_s)

    @my_lookup = Securities::Lookup.new('SPY')

    #@my_data = Indicators::Data.new(Securities::Stock.new(:symbol => 'AAPL', 
      #:start_date => '2015-10-01', :end_date => '2015-11-09').output)

  end
end
