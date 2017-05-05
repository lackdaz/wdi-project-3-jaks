class MqttController < ApplicationController
  def start
    MqttJob.set(wait: 2.seconds).perform_later
    render html: '404'
  end
end
