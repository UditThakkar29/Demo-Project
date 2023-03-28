class Project < ApplicationRecord
  # belongs_to :user

  extend FriendlyId
  friendly_id :generated_slug, use: :slugged

  has_and_belongs_to_many :users
  has_one :board, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  after_create :create_board
  # before_destroy :delete_board

  def generated_slug
    @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(8)
  end

  private
  def create_board
    Project.last.build_board(name: "#{Project.last.name}-Board").save
  end

  # def delete_board
  #   Project.last.board.destroy
  # end

end
