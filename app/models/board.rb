class Board < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :project
  has_many :sprints, dependent: :destroy
end
