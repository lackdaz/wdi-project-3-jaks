class OrderitemsController < ApplicationController

  def index

      @delivery = DeliveryAddress.new
      @orders = Orderitem.where(user_id: current_user.id, invoice_id: nil)
    end

    def new
      puts "start"
      puts params[:flavour]
      puts params[:supplier]
      puts params.inspect
      puts "end"
      @order = Orderitem.new

    end

    def create
      @new_order = Orderitem.new(filter_params)
      puts @new_order.inspect
      @new_order.save
    end

    def destroy
      deleted_order = Orderitem.find(params[:id])
      deleted_order.destroy
      redirect_to orderitems_path
    end

    private
    def filter_params
      params.require(:orderitem).permit(:flavour, :price, :name, :flavour_id, :supplier_id, :container_id, :user_id)
    end
end
