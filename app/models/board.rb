# frozen_string_literal: true

# Model to store all Board which are created on project creation.
class Board < ApplicationRecord

  extend FriendlyId
  friendly_id :generated_slug, use: :slugged

  validates :name, presence: true, uniqueness: true

  belongs_to :project
  has_many :sprints, dependent: :destroy

  def generated_slug
    @generated_slug ||= persisted? ? friendly_id : SecureRandom.hex(8)
  end

end
