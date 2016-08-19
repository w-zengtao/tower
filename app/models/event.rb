class Event < ApplicationRecord

  # associations
  belongs_to :eventable, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :operator, class_name: 'User', foreign_key: :operator_id

  # delegate
  delegate :name, to: :operator, prefix: :operator, allow_nil: true
  delegate :name, to: :user, prefix: :user, allow_nil: true

  # callbacks
  after_create_commit do
    EventBroadcastJob.perform_later(self.id)
  end
end
