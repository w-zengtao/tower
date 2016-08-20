class EventsController < BaseController
  def index
    @events = Event.includes(:operator, :eventable).order(created_at: 'desc').group_by { |e| e.created_at.to_date }
  end
end
