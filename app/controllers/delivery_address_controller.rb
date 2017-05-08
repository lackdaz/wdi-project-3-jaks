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



  private
  def delivery_address_params
    params.require(:delivery_address).permit(:address)
  end

end
