class Comment < ApplicationRecord

  # associations
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :todo

  has_many :events, as: :eventable, class_name: 'Event'

  # scope
  default_scope -> { order('created_at ASC') }

  # callbacks
  after_commit :notify_event_when_create, on: :create
  def notify_event_when_create
    notify_event('发表了')
  end

  # methods
  def name
    content
  end

  private
  def notify_event(act)
    CommentJob.perform_now(User.current.id, nil, self.class.name, self.id, act)
  end
end
