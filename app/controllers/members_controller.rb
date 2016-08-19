class MembersController < BaseController

  before_action :set_user_by_id

  def create
    @team_user = @user.team_users.find_or_initialize_by(team: @current_team)
    @team_user.level = params[:member][:user_level].to_i
    if @team_user.save
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def set_user_by_id
    @user = User.find_by(id: params[:member][:id])
  end
end
