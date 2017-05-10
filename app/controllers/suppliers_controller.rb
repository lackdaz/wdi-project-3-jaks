class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
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

  def picture_params
  params.require(:picture).permit(:public_id)
end


end
