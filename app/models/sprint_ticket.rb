class SprintTicket < ApplicationRecord
  belongs_to :sprint, dependent: :destroy
  belongs_to :ticket, dependent: :destroy
end
