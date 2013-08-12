class MixDown < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id

  belongs_to :user
  belongs_to :project
  has_many :tracks, :through => :mix_down_tracks
  has_many :mix_down_tracks

   def add_bulk_tracks(track_array)
    track_array.each do |track|
      self.tracks << Track.find(track)
    end
  end
end
