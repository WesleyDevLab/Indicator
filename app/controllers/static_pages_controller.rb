class StaticPagesController < ApplicationController
  def index
    @security = Security.new
  end
end
