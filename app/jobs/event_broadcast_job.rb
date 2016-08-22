class EventBroadcastJob < ApplicationJob
  queue_as :websocket

  def perform(event_id)
    # 只有当前用户也 在这个当前 event 关联的 project 里面的时候才给推送
    @event = Event.find(event_id)
    ActionCable.server.broadcast 'event_channel',  { event: render_event(@event), date_id: @event.created_at.to_date }
  end

  private
  def render_event(event)
    ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
  end
end
