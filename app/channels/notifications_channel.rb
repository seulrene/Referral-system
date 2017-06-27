class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "notifications_channel:#{current_user.id}"
    stream_for "notifications_channel:#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("notifications_channel:#{current_user.id}", data)
  end
end
