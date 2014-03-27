class Project < ActiveRecord::Base
  attr_accessible :name, :creator_id

  belongs_to :creator, :class_name => 'User'
  has_one :master_track
  has_many :mix_downs
  has_many :genres, :through => :project_genres
  has_many :project_genres
  has_many :tracks
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  def self.tracks_with_associations(project)
    project.tracks.map do |track|
      track.with_associations
    end
  end

  def self.mix_downs_with_associations(project)
    project.mix_downs.map do |mix_down|
      mix_down.with_associations
    end
  end
end
