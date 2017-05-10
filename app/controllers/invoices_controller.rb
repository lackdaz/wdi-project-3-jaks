class InvoicesController < ApplicationController
 include SendEmail

  def index
    @orders = Invoice.where(user_id: current_user.id)

    #  need to change to last known
    # gon.lat = 1.3521
    # gon.long = 103.8198
    # @all_transactions = current_user.transaction
  end

  def new
    redirect_to new_order_path
    #build with the user
  end

  def create

    @delivery_address = DeliveryAddress.where(user_id: current_user.id)

    if (!@delivery_address)
      redirect_to orderitems_path
    end

    begin
    @amount = (params[:total_amount].to_f * 100).to_i


    puts "START"
    puts params.inspect
    puts "END"

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe Icecream',
      :currency    => 'SGD'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to orderitems_path
    end

    # send_message(current_user.firstname, params[:stripeEmail], "Your ice-cream is on the way!", "Thank you for your purchase with Ice Scream! Enjoy your ice-cream!" )
    @orders = Orderitem.where(user_id: current_user.id, invoice_id: nil)
    @new_invoice = Invoice.new
    @new_invoice.user_id = current_user.id
    @new_invoice.delivery_address_id = 1
    @new_invoice.status = "PAID"
    if @new_invoice.save
      puts @orders
      @orders.each do |order|
        order.invoice_id = @new_invoice.id
        order.save
      end
      redirect_to invoices_path
    end

  end
  # to move this to relevant search bar view/controller
  def location_search
      # the below is hard coded, but to search from database for all suppliers.

      # gon.suppliers = Supplier.all
      gon.suppliers = [
        {id: 1, name: 'test', lat:-34.397, lng:150.644},
        {id: 2, name: 'test2', lat: 1.3521, lng: 103.8198},
        {id: 3, name: 'test3', lat: 1.30838, lng: 103.83264},
        {id: 4, name: 'test4', lat: 1.30838, lng: 103.83264},
        {id: 5, name: 'test5', lat: 1.30838, lng: 103.83264},
        {id: 6, name: 'test6', lat: 1.30838, lng: 103.83264},
        {id: 7, name: 'test7', lat: 1.30838, lng: 103.83264}]

  end

    def search
      ##### search function below is done but need to connect to supplier db


      # field = params[:field]? params[:field].downcase : ''
      # @suppliers = Supplier.where("LOWER(name) LIKE ? OR LOWER(location) = ?", "%#{field}%", "%#{field}%")

    end
  # private
  # def filter_params
  #   params.require(:order).permit(:flavor, :price, :name)
  # end

end
