class ProjectsController < BaseController

  before_action :set_project, only: [:show]

  def index
    @current_team = Team.includes(:projects).find_by(id: current_user.default_team_id) # 这里重新查找是为了避免 N + 1
    @projects = @current_team.projects
  end

  def show
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = @current_team.projects.find_or_initialize_by(project_params)
    if @project.save
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
