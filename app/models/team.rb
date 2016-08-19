class Team < ApplicationRecord

  # associations
  has_many :team_users
  has_many :users, through: :team_users
  has_many :projects

  # callbacks
   after_commit :notify_team_user, on: :create
   def notify_team_user
     @team_user = self.team_users.first #这里隐含逻辑是： 创建的时候不会邀请新的成员
     @team_user.update_attribute('level', 0) # SuperAdmin
   end

   after_commit :notify_user_default_team, on: :create
   def notify_user_default_team
     User.current.set_default_team(self)
   end
end
