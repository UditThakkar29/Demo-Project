# frozen_string_literal: true

# Model to have relationship between Sprints and Tickets.
class SprintTicket < ApplicationRecord
  belongs_to :sprint
  belongs_to :ticket
end
