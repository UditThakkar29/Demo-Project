class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
  
  # has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
  # has_one :manager, -> { where(:roles => {name: :manager}) }, through: :roles, class_name: 'User', source: :users
end
