class EventBroadcastJob < ApplicationJob
  queue_as :callbacks

  def perform(event_id)
    # TODO Broadcast Websocket Message
  end
end
