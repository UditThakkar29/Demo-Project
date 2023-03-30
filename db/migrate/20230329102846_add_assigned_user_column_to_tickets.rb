class AddAssignedUserColumnToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :assigned_user_id, :integer
  end
end
