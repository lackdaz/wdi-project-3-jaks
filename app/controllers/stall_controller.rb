class StallController < ApplicationController



  def new
    Stall.new
  end

  def show
  end

  def index
    @stall = Stall.all
  end

  def edit
  end

end
