class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    p 'start'
    p current_supplier
    p 'end'
    @flavours = Flavour.where(supplier_id: params[:id])
    @supplier = Supplier.find(params[:id])
  end


end
