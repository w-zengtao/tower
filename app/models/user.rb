class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associations
  has_many :team_users
  has_many :teams, through: :team_users        # 归属的团队

  # object methods
  def set_default_team(team)
    update_attribute('default_team_id', team.id)
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
