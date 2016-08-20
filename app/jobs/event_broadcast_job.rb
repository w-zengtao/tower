class EventBroadcastJob < ApplicationJob
  queue_as :websocket

  def perform(event_id)
    @event = Event.find(event_id)
    ActionCable.server.broadcast 'event_channel',  { event: render_event(@event), date_id: @event.created_at.to_date }
  end

  private
  def render_event(event)
    ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
  end
end
