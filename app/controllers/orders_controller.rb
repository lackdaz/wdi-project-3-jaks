class OrdersController < ApplicationController

  def index
    @all_orders = current_user.order
  end

  def new
    @new_order = Order.new
  end

  def create
##### to update based on Kenneth's input
    @new_order = Order.new(filter_params)
    @submitted_flight.save
     redirect_to orders_path
  end

  def destroy
    deleted_order = Order.find(params[:id])
    deleted_order.destroy
    redirect_to orders_path
  end

  private
  def filter_params
    params.require(:order).permit(:flavor, :price, :name)
  end



end

  # def show
  #   # find flight by id
  #   @individual_order = Order.find(params[:id])
  #   # pass the data into your js
  #   # alert the data into the screen
  # end

  # def edit
  #   @individual_order = Order.find(params[:id])
  # end
  # def update
  #   #  @submitted_flight = params[:flight]
  #   #  @saved_flight = Flight.new
  #   #  @saved_flight.from = @submitted_flight[:from]
  #    @updated_order = Order.find(params[:id])
  #
  #   if @updated_order.update(filter_params)
  #        redirect_to orders_path
  #   end
  #
  # end
