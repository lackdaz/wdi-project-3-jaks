class DeliveryAddressController < ApplicationController
  def create
  @delivery_address =DeliveryAddress.new(delivery_address_params)
  @delivery_address.user_id = current_user.id
  if @delivery_address.save
    redirect_to root_path
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
    render "delivery_address/edit_delivery_address"
  end

def update_delivery_address

end



  private
  def delivery_address_params
    params.require(:delivery_address).permit(:address)
  end

end
