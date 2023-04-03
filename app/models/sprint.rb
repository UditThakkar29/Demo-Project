# frozen_string_literal: true

# Model to store all Sprints which are created from board.
class Sprint < ApplicationRecord
  # url slug
  extend FriendlyId
  friendly_id :generated_slug, use: :slugged

  # validations
  # validates :name, presence: true, uniqueness: true
  validates :board_id, uniqueness: {scope: :name}
  validates :start_time, presence: true
  validates :goal, presence: true

  # associations
  belongs_to :board
  has_many :sprint_tickets, dependent: :destroy
  has_many :tickets, through: :sprint_tickets

  # scopes
  scope :current_sprint, -> {where(current_sprint: true)}
  scope :backlog_sprint, -> {where(backlog_sprint: true)}

  def generated_slug
    @generated_slug ||= persisted? ? friendly_id : SecureRandom.hex(8)
  end
end
