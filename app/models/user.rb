class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associations
  has_many :team_users
  has_many :teams, through: :team_users        # 归属的团队
  has_many :todos                              # 名下的任务
  has_many :accesses
  has_many :projects, through: :accesses

  belongs_to :team, class_name: 'Team', foreign_key: 'default_team_id', optional: true

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
    'admin' == accesses.find_by(project_id: project.id).level
  end

  # 用户当前能否访问一个项目(用户必须切换到当前项目的团队的时候才能访问当前团队下面用户参与的项目)
  def can_access?(project)
    if team != project.team
      false
    else
      projects.include? project
    end
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
