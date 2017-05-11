class DeliveryAddressController < ApplicationController
  def create
  @delivery_address =DeliveryAddress.new(delivery_address_params)
  @delivery_address.user_id = current_user.id
  if @delivery_address.save
    @invoice.user_id= current_user.id
  else
    render "users/registrations/show"
  end
  end


  def show_delivery_address
    p 'finding user_id'
    @user_delivery_address = DeliveryAddress.Post.find_by user_id: current_user.id
    render "delivery_address/show_delivery_address"

  end

  def edit_delivery_address
     @delivery_address = DeliveryAddress.find(params[:id])
    render "delivery_address/edit_delivery_address"
  end

def update_delivery_address
    @delivery_address = DeliveryAddress.find(params[:id])
    if @delivery_address.update(delivery_address_params) # if this update is successful
      redirect_to root_path
    end
end

def destroy_delivery_address
  @deleted_delivery_address = DeliveryAddress.find(params[:id])

  @deleted_delivery_address.destroy

  redirect_to root_path
end





  private
  def delivery_address_params
    params.require(:delivery_address).permit(:address)
  end

end
