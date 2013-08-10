class TrackInstrument < ActiveRecord::Base
  attr_accessible :track_id, :instrument_id

  belongs_to :track
  belongs_to :instrument
end
