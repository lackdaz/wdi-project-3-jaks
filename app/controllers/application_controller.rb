class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :run_mqtt

  private
  def run_mqtt
    # if MqttJob

    # MqttJob.set(wait: 2.seconds).perform_later
    MqttJob.set(wait: 2.seconds).perform_later if cookies[:_aj].nil?
    cookies[:_aj] = {
      :value => "raymond",
      :expires => 1.hour.from_now
    }
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :firstname, :lastname, :contact, :address, :website])
  end
end
