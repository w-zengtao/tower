module ApplicationHelper

  def current_level(user = current_user)
    TeamUser.find_by(team: @current_team, user: user).level
  end
  
end
