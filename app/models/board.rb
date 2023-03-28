class Board < ApplicationRecord

  extend FriendlyId
  friendly_id :generated_slug, use: :slugged

  validates :name, presence: true, uniqueness: true

  belongs_to :project
  has_many :sprints, dependent: :destroy

  def generated_slug
    require 'securerandom'
    @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  end

end
