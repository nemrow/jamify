class MixDownTrack < ActiveRecord::Base
  attr_accessible :mix_down_id, :track_id

  belongs_to :mix_down
  belongs_to :track
end
