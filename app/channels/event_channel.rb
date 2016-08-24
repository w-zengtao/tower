# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class EventChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    if self.current_user_id
      stream_from "event_channel"
    end
  end

  def unsubscribed
    stop_all_streams
  end

end
