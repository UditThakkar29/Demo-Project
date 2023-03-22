class Project < ApplicationRecord
  # belongs_to :user
  has_and_belongs_to_many :users
  has_one :board, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  after_create :create_board
  # before_destroy :delete_board

  private
  def create_board
    Project.last.build_board(name: "#{Project.last.name}-Board").save
  end

  # def delete_board
  #   Project.last.board.destroy
  # end

end
