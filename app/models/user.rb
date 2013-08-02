class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :sc_id
  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :sc_id, presence: true, numericality: true
end
