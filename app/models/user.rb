class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :sc_id
  has_many :followings, :through => :user_followings
  has_many :user_followings
  has_many :master_tracks
  has_many :tracks
  
  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :sc_id, presence: true, numericality: true
end
