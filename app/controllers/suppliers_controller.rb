class SuppliersController < ApplicationController
  def index
  end

  def new
    @new_supplier = Supplier.new
  end
end
