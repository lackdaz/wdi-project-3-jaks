require 'mqtt'
require 'uri'
require 'cgi'

class MqttJob < ApplicationJob
  # set how often you wish to run it here
  RUN_EVERY = 5.seconds
  queue_as :urgent

  def perform(*_args)
    # sets up the recurring job

    # Create a hash with the connection parameters from the URL or collect to the local mqtt client server (on heroku)
    uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'

    conn_opts = {
      remote_host: uri.host,
      remote_port: uri.port,
      username: uri.user,
      password: uri.password
    }
    puts conn_opts

    # Subscribe example
    Thread.new do
      MQTT::Client.connect(conn_opts) do |c|
        # The block will be called when you messages arrive to the topic
        c.get('current_GPS') do |topic, message|
          puts "#{topic}: #{message}"
          # broadcasts the message upon receiving it via action cable
          ActionCable.server.broadcast 'update_gps_channel', # code
                                       content: message,
                                       author: 'seth'
          # username: current_user
        end
      end
    end

    # Publish example
    MQTT::Client.connect(conn_opts) do |c|
      # publish a message to the topic 'action' -- polls the device via the MQTT server to request for GPS coordinates
      c.publish('action', '1', retain = false)
    end
    #  automagically enqueues the task again to run every x.time
    self.class.perform_later(wait: RUN_EVERY)
  end
end
