class Project < ApplicationRecord
  # associations
  belongs_to :team
  has_many :todos
  has_many :accesses
  has_many :members, through: :accesses, source: 'user'

  # callbacks
  after_create_commit :notify_access
  def notify_access
    add_member(User.current)
  end

  # methods
  def add_member(user)
    # 这里要判断 user 是不是自己 || user 在当前团队的角色
    level = 'default'
    if ([0, 1].include? user.role(team)) || ( user == User.current )
      level = 'admin'
    end
    add_member_by_level(user, level)
  end

  private
  def add_member_by_level(user, level)
    accesses.create(user: user, level: level)
  end


end
