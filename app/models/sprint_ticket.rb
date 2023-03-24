class SprintTicket < ApplicationRecord
  belongs_to :sprint
  belongs_to :ticket
end
