class Project < ActiveRecord::Base
  attr_accessible :name, :creator_id

  belongs_to :creator, :class_name => 'User'
  has_one :master_track
  has_many :mix_downs
  has_many :genres, :through => :project_genres
  has_many :project_genres
  has_many :tracks
  has_many :likes, :as => :likeable
end
