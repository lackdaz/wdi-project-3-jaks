class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :run_mqtt
  # before_action :geocode
  #
  # include Geokit::Geocoders

  private
  def run_mqtt
    # if MqttJob
    puts "Data starts from HERE HERE HERE!!!!!!!!!!!!!!!!!"
    puts cookies[:_aj].inspect
    # MqttJob.set(wait: 2.seconds).perform_later
    MqttJob.set(wait: 2.seconds).perform_later if cookies[:_aj].nil?
    cookies[:_aj] = {
      :value => true,
      :expires => 10.seconds.from_now
    }
    # puts cookies[:_aj].inspect

  end

  # def geocode
  #   loc=MultiGeocoder.geocode('362 Onan Rd, Singapore 424758')
  #   if loc.success
  #     puts loc.lat
  #     puts loc.lng
  #     puts loc.full_address
  #   end
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :firstname, :lastname, :contact, :address, :website])
  end
end
