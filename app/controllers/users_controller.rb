class UsersController < ApplicationController
def show
@delivery_addresses = DeliveryAddress.where(user_id: current_user.id)
render  "users/registrations/show"
end

def new
  render "users/registrations/new"
end


end
