class EventBroadcastJob < ApplicationJob
  queue_as :websocket

  def perform(event_id)
    @event = Event.find(event_id)
    # @event.broadcast_to_client
    ActionCable.server.broadcast 'event_channel',  { line: render_line(@event), event: render_event(@event), date_id: @event.created_at.to_date, user_ids: @event.be_notified_users }
  end

  private
  def render_event(event)
    ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
  end

  def render_line(event)
    ApplicationController.renderer.render(partial: 'events/line', locals: { event: event })
  end
end
