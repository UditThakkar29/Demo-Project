# frozen_string_literal: true

# Model to store all Users.
class User < ApplicationRecord
  after_create :assign_default_role
  rolify
  # has_many :projects
  # has_many :projects, through: :roles, source: :resource, source_type:  :Project
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  has_and_belongs_to_many :projects
  has_one :subscription
  # pay_customer stripe_attributes: :stripe_attributes

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def check_subsciption_status
    subscription =  Stripe::Subscription.retrieve(self.subscription.subscription_key)
    return if subscription.nil?
    self.subscription.update(
      subscription_status: subscription.status,
      subscription_end_date: Time.at(subscription.current_period_end).to_date,
      subsciption_start_date: Time.at(subscription.current_period_start).to_date
    )
  end

  def active_subscription?

    check_subsciption_status if self.subscription&.subscription_end_date.nil? || self.subscription&.subscription_end_date.to_date < Time.now.to_date
    if self.subscription.nil? or self.subscription&.subscription_end_date.to_date < Time.now.to_date
      return false
    else
      return true
    end

  end
end
