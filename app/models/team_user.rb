class TeamUser < ApplicationRecord

  LEVEL = {
    0 => '超级管理员',
    1 => '管理员',
    2 => '成员',
    3 => '访客'
  }

  PAGE_LEVEL = {
    '管理员' => 1,
    '成员' => 2,
    '访客' => 3
  }

  # validation
  validates :team_id, presence: true, uniqueness: { scope: :user_id }

  # associations
  belongs_to :team
  belongs_to :user
end
