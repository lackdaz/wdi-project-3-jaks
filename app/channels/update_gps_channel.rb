class UpdateGpsChannel < ApplicationCable::Channel
  def subscribed
    # stream_for pie
    stream_from 'update_gps_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
