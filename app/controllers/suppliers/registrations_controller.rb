
class Suppliers::RegistrationsController < Devise::RegistrationsController

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  include Geokit::Geocoders

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected


def after_sign_up_path_for(resource)
  # @updated_supplier = Supplier.find(params[:id])
  # if @updated_flight.update(filter_params)

  loc=MultiGeocoder.geocode(filter_params[:address])
    if loc.success
      updated_supplier = Supplier.last
      updated_supplier.lat = loc.lat.to_f
      updated_supplier.lng = loc.lng.to_f
      updated_supplier.address = loc.full_address
      updated_supplier.neighbourhood = loc.neighborhood
      updated_supplier.save
    end
  suppliers_path(resource)  #the path you want to route to
end

private
def filter_params
  params.require(:supplier).permit(:address)

end
end
