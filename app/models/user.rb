# frozen_string_literal: true

# Model to store all Users.
class User < ApplicationRecord
  after_create :assign_default_role
  rolify
  attr_accessor :login
  # has_many :projects
  # has_many :projects, through: :roles, source: :resource, source_type:  :Project
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  has_and_belongs_to_many :projects
  has_one :subscription
  validates :username, presence: true, uniqueness: true
  # pay_customer stripe_attributes: :stripe_attributes

  def login
    @login || self.email || self.phone || self.username
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def check_subsciption_status
    stripe_key = self.subscription&.subscription_key
    return if stripe_key.nil?
    subscription =  Stripe::Subscription.retrieve(stripe_key)
    self.subscription.update(
      subscription_status: subscription.status,
      subscription_end_date: Time.at(subscription.current_period_end).to_date,
      subsciption_start_date: Time.at(subscription.current_period_start).to_date
    )
  end

  def active_subscription?

    check_subsciption_status if self.subscription&.subscription_end_date.nil? || self.subscription&.subscription_end_date.to_date < Time.now.to_date
    if self.subscription.nil? or self.subscription&.subscription_end_date.to_date < Time.now.to_date or self.subscription.subscription_status != "active"
      return false
    else
      return true
    end
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(phone) ILIKE '%#{login.downcase}%' OR lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end

