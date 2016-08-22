class EventsController < BaseController
  def index
    # TODO 这里应该只能看到当前用户 当前团队的 有权限的项目的 事件
    @events = Event.includes(:operator, :eventable, :user).order(created_at: 'desc').group_by { |e| e.created_at.to_date }
  end
end
