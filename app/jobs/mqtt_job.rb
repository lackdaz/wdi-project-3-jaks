# require 'mqtt'
# require 'uri'
# require 'cgi'
#
# class MqttJob < ApplicationJob
#   queue_as :urgent
#
#   def perform(*args)
#
#
#       # Create a hash with the connection parameters from the URL
#       uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
#
#       conn_opts = {
#         remote_host: uri.host,
#         remote_port: uri.port,
#         username: uri.user,
#         password: uri.password,
#       }
#       puts conn_opts
#
#       # Subscribe example
#       Thread.new do
#         MQTT::Client.connect(conn_opts) do |c|
#           # The block will be called when you messages arrive to the topic
#           c.get('current_GPS') do |topic, message|
#             puts "#{topic}: #{message}"
#             ActionCable.server.broadcast 'update_gps_channel',    #code
#             content: message,
#             author: "seth"
#             # username: current_user
#           end
#         end
#       end
#
#       # Publish example
#       MQTT::Client.connect(conn_opts) do |c|
#         # publish a message to the topic 'test'
#         loop do
#           c.publish('action', '1', retain=false)
#           sleep 5
#         end
#       end
#   end
# end
