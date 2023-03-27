class Board < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  belongs_to :project
  has_many :sprints, dependent: :destroy
end
