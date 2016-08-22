class Comment < ApplicationRecord

  # associations
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  # scope
  default_scope -> { order('created_at ASC') }
end
