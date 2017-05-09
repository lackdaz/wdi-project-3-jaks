class Suppliers::RegistrationsController < Devise::RegistrationsController

  # require 'rubygems'
  # require 'geokit'
  include Geokit::Geocoders
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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

  protected

  def after_sign_up_path_for(resource)
    # @updated_supplier = Supplier.find(params[:id])
    # if @updated_flight.update(filter_params)

    loc=MultiGeocoder.geocode('362 Onan Rd, Singapore 424758')
      if loc.success
        puts loc.lat
        puts loc.lng
        puts loc.full_address
      end
    suppliers_path(resource)  #the path you want to route to
end

private

# filter method called by create and update
def filter_params
  params.require(:supplier).permit(:address)
end
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
end
