class MixDown < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id

  belongs_to :user
  belongs_to :project
  has_many :tracks, :through => :mix_down_tracks
  has_many :mix_down_tracks
end
