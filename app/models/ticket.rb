class Ticket < ApplicationRecord
  has_many :sprint_tickets
  has_many :sprints, through: :sprint_tickets
end
