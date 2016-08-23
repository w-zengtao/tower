# operator_id  事件的直接操作者
# user_id      事件的被动接收者
#

class Event < ApplicationRecord

  # associations
  belongs_to :eventable, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :operator, class_name: 'User', foreign_key: :operator_id
  belongs_to :project

  # delegate
  delegate :name, to: :operator, prefix: :operator, allow_nil: true
  delegate :name, to: :user, prefix: :user, allow_nil: true

  # callbacks
  after_create_commit do
    EventBroadcastJob.perform_later(self.id)
  end

  # methods
  def name
    self.eventable.send(:name)
  end

  # class methods
  class << self
    def events_with_projects(projects)
      Event.joins(:project).includes(:operator, :eventable, :user).merge(projects).uniq.order(created_at: 'desc').group_by { |e| e.created_at.to_date }
    end
  end
end
