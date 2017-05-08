class TransactionsController < ApplicationController

  def index
    #  need to change to last known
    gon.lat = 1.3521
    gon.long = 103.8198

    # @all_transactions = current_user.transaction
  end

  def new
    redirect_to new_order_path
    #build with the user
  end

  def create
    # @new_transaction = Transaction.new
##### to update based on Kenneth's input
    # @new_order = Order.new(filter_params)
    # @submitted_flight.save
    #  redirect_to transactions_index_path
  end


  # private
  # def filter_params
  #   params.require(:order).permit(:flavor, :price, :name)
  # end

end
