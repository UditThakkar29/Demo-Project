class User < ApplicationRecord
  after_create :assign_default_role
  rolify
  # has_many :projects
  has_and_belongs_to_many :projects
  # has_many :projects, through: :roles, source: :resource, source_type:  :Project
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
