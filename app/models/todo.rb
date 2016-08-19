class Todo < ApplicationRecord
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
    notify_event('create')
  end

  after_commit :notify_event_when_update, on: :update
  def notify_event_when_update
    notify_event('update')
  end

  private
  def notify_event(act)
    TodoJob.perform_later(User.current.id, self.user_id, self.class.name, self.id, act)
  end
end
