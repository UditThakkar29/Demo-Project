class Project < ApplicationRecord
  # belongs_to :user
  has_and_belongs_to_many :users
  has_one :board, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  after_create :create_board

  # has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
  # has_one :manager, -> { where(:roles => {name: :manager}) }, through: :roles, class_name: 'User', source: :users
  # private
  def create_board
    Project.last.build_board(name: "dommy").save
  end

end
