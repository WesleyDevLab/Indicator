class TradesController < ApplicationController
  before_action :authenticate_user!

  def index
    @trade = Trade.new

    trades = @trade.get_table_data(current_user.trades.all)
    gon.trades = trades
  end

  def create
    current_user.trades.create(trade_params)
    redirect_to trades_path
  end

  private

  def trade_params
    params.require(:trade).permit(
      :underlying, :expiration, :option_type, :short_strike_price, :long_strike_price, :user_id
    )
  end
end
