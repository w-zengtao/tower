class EventsController < BaseController
  def index
    @team_projects = current_user.team.projects
    @user_projects = current_user.projects
    @projects = @team_projects.merge(@user_projects) # 当前团队的项目 并且 当前用户 有 权限访问的项目
    @events = Event.events_with_projects(@projects)
  end
end
