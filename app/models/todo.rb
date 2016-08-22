class Todo < ApplicationRecord
  include SoftDelete

  STATE = {
    0 => '创建了',
    1 => '开始了',
    2 => '暂停了',
    3 => '指派了', # 指派和重新指派默认会消除任务的 暂停状态
    4 => '重新打开了',
    5 => '重新指派了',
    10 => '完成了'
  }

  # validates
  validates :user_id, numericality: { only_integer: true }, allow_nil: true

  # associations
  belongs_to :user, optional: true
  belongs_to :project

  has_many :events, as: :eventable, class_name: 'Event'

  # callbacks
  # ['create', 'update'].each do |action|
  #   after_commit "notify_event_when_#{action}", on: "#{action}"
  # end

  after_commit :notify_event_when_create, on: :create
  def notify_event_when_create
    notify_event('创建了')
  end

  after_commit :notify_event_when_update, on: :update
  def notify_event_when_update
    notify_event(Todo::STATE[state])
  end

  after_destroy :notify_event_when_destroy
  def notify_event_when_destroy
    notify_event('删除了')
  end

  # scopes
  scope :valid, -> { where(deleted_at: nil) }
  scope :finished, -> { where(state: 10)  }
  scope :unfinished, -> { where.not(state: 10)  }

  # methods
  def done?
    10 == state
  end

  def pause?
    2 == state
  end
  private
  def notify_event(act)
    TodoJob.perform_later(User.current.id, self.user_id, self.class.name, self.id, act)
  end
end
