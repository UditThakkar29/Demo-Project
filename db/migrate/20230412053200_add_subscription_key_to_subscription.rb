class AddSubscriptionKeyToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :subscription_key, :string
  end
end
