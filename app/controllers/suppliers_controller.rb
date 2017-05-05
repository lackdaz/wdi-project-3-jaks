class SuppliersController < ApplicationController
  def index
    puts current_user
    @suppliers = Supplier.all
  end

  def show

  end


end
