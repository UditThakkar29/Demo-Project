class Ticket < ApplicationRecord

  include AASM
  has_many :sprint_tickets, dependent: :destroy
  has_many :sprints, through: :sprint_tickets

  aasm column: 'status', :whiny_transitions => false do
    state :to_do, initial: true
    state :progress
    state :qa
    state :done

    after_all_transitions :log_status_change

    event :doing do
      transitions from: [:to_do, :qa], to: :progress
    end
    event :testing do
      transitions from: [:progress], to: :qa
    end
    event :done do
      transitions from: [:qa], to: :done
    end

  end


  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state}"
  end
end
