class Sprint < ApplicationRecord
  belongs_to :board
  has_many :sprint_tickets, dependent: :destroy
  has_many :tickets, through: :sprint_tickets
end
