class BaseController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_model_current_user
  before_action :ensure_default_team

  private
  def set_model_current_user
    User.current = current_user
  end

  def ensure_default_team
    # @current_team = current_user.teams.find_by(id: current_user.default)
    @current_team = Team.find_by(id: current_user.default_team_id)
    if @current_team
      @current_team
    else
      redirect_to new_team_path
    end
  end

end
