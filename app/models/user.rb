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
  has_one :subcription
  # pay_customer stripe_attributes: :stripe_attributes

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  # def stripe_attributes(pay_customer)
  #   {
  #     address: {
  #       city: pay_customer.owner.city,
  #       country: pay_customer.owner.country
  #     },
  #     metadata: {
  #       pay_customer_id: pay_customer.id,
  #       user_id: id
  #     }
  #   }
  # end

end
