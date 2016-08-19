class ProjectsController < BaseController

  def index
    @projects = @current_team.projects
  end

  def show
  end
end
