class TeamsController < BaseController
  skip_before_action :ensure_default_team, only: [:new, :create]

  def show
    @members = @current_team.users
  end

  def index
  end

  def new
    @team = Team.new
  end

  def create
    if @team = current_user.teams.create(team_param)
      flash[:notice] = "团队创建成功"
      redirect_to team_path(@team)
    else
      flash.now[:error] = "团队创建失败"
      render action: "new"
    end
  end

  private

  def team_param
    params.require(:team).permit(:name)
  end
end
