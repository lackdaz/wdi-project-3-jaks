class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
end
