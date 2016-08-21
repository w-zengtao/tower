class Access < ApplicationRecord

  # validation
  validates :project_id, presence: true, uniqueness: { scope: :user_id }

  # associations
  belongs_to :project
  belongs_to :user
end
