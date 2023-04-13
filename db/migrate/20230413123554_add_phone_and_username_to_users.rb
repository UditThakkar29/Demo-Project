class AddPhoneAndUsernameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :username, :string
  end
end
