class Project < ApplicationRecord
  # associations
  belongs_to :team
  has_many :todos

end
