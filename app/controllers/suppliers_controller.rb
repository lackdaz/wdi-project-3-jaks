class SuppliersController < ApplicationController
  # before_action :authenticate_user!, only: [:index, :new]

  def index
    @suppliers = Supplier.all
  end

  def new
    @new_supplier = Supplier.new
  end
end
