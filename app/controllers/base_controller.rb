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
    
  end

end
