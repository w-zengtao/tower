class ChangeTeamsController < BaseController
  def create
    team_id = params[:team_id].to_i
    current_user.update_attribute('default_team_id', team_id)
    respond_to do |format|
      format.json { render json: { message: team_id } }
    end
  end
end
