class SuppliersController < ApplicationController
  def index

    @suppliers = Supplier.all
  end

  def show
    p 'start'
    p current_supplier
    p 'end'
    @flavours = Flavour.where(supplier_id: current_supplier.id)
  end


end
