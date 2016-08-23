class EventsController < BaseController
  def index
    @team_projects = current_user.team.projects
    @user_projects = current_user.projects
    @projects = @team_projects.merge(@user_projects)
    @events = Event.events_with_projects(@projects)
  end
end
