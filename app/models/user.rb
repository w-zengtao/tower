class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associations
  has_many :team_users
  has_many :teams, through: :team_users        # 归属的团队
  has_many :todos                              # 名下的任务

  # object methods
  def set_default_team(team)
    update_attribute('default_team_id', team.id)
  end

  # 用户在当前 team 的角色
  def role(team)
    @team_user = team_users.find_by(team: team)
    @team_user.level if @team_user
  end

  # 用户是否能 Admin 一个项目
  def can_admin?(project)
  end

  # class methods
  class << self
    def current
      Thread.current[:user]
    end

    def current=(user)
      Thread.current[:user] = user
    end
  end
end
