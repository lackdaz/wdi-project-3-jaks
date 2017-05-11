class MqttJob < ApplicationJob
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
    # Threads are the most awesome thing ever
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
    # Threads are the most awesome thing ever
    Thread.new do
      MQTT::Client.connect(conn_opts) do |c|
        # publish a message to the topic 'test'
        loop do
          # polling the device for GPS coordinates please
          c.publish('action', '1', retain = false)
          # set the time frequency here
          sleep 2
        end
      end
    end
  end
end
