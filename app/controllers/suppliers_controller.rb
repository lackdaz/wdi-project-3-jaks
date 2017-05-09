class SuppliersController < ApplicationController

  def index
    # @suppliers = Supplier.all

    field = params[:field]? params[:field].downcase : ''
    @suppliers = Supplier.where("LOWER(name) LIKE ? OR LOWER(address) = ?", "%#{field}%", "%#{field}%")
  end

  def show

    if user_signed_in?

    @user = User.find(current_user)
    end
    p 'start'
    p current_supplier
    p 'end'
    @flavours = Flavour.where(supplier_id: params[:id])
    @supplier = Supplier.find(params[:id])
    @containers = Container.where(supplier_id: params[:id])
    @order = Orderitem.new
    gon.user = user_signed_in?
  end

  def location_search
      gon.suppliers = Supplier.all
  end



end
