class InvoicesController < ApplicationController
  include SendEmail
  # QUEUES the run_mqtt recurring active job only on the show function
  before_action :run_mqtt, only: [:show]

  def index
    @orders = []
    @invoice = Invoice.where(user_id: current_user.id, status: 'PAID')
    @invoice.each do |e|
      Orderitem.where(invoice_id: e.id).each do |order|
        @orders << order
      end
    end
  end

  def show
    @invoice = Invoice.find(params[:id])

    puts @orders = Orderitem.where(invoice_id: params[:id])

    # required for views and javascript -- passing store addresses to be geocoded
    @start = @orders[0].supplier.address
    gon.start = @orders[0].supplier.address

    # required for views and javascript -- passing delivery addresses to be geocoded
    @destination = @invoice.delivery_address.address
    gon.destination = @invoice.delivery_address.address
  end

  def create

    puts "INVOICEEEEERRRRRR"
    @delivery_address = DeliveryAddress.where(user_id: current_user.id)

    redirect_to orderitems_path unless @delivery_address

    redirect_to orderitems_path unless @delivery_address

    begin
      @amount = (params[:total_amount].to_f * 100).to_i

      puts 'START'
      puts params.inspect
      puts 'END'

      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe Icecream',
        currency: 'SGD'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to orderitems_path
    end

    # send_message(current_user.firstname, params[:stripeEmail], "Your ice-cream is on the way!", "Thank you for your purchase with Ice Scream! Enjoy your ice-cream!" )
    @orders = Orderitem.where(user_id: current_user.id, invoice_id: nil)
    @new_invoice = Invoice.new
    @new_invoice.user_id = current_user.id
    @new_invoice.delivery_address_id = address_param['delivery_address_id']
    @new_invoice.status = 'PAID'

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

  private

  def address_param
    params.require(:invoice).permit(:delivery_address_id)
  end
  # private
  # def filter_params
  #   params.require(:delivery_address).permit(:flavor, :price, :name)
  # end
end
