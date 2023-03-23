class Board < ApplicationRecord
  belongs_to :project
  has_many :sprints, dependent: :destroy
end
