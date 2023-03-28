class Sprint < ApplicationRecord

  extend FriendlyId
  friendly_id :generated_slug, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :start_time, presence: true
  validates :start_time, presence: true
  validates :goal, presence: true

  belongs_to :board
  has_many :sprint_tickets, dependent: :destroy
  has_many :tickets, through: :sprint_tickets

  def generated_slug
    require 'securerandom'
    @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  end
end
