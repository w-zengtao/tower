module TeamsHelper
  def can_admin?
    [0, 1].include? current_level
  end
end
