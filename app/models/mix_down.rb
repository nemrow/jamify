class MixDown < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id

  belongs_to :user
  belongs_to :project
  has_many :tracks, :through => :mix_down_tracks
  has_many :mix_down_tracks

  def add_bulk_tracks(track_array)
    track_array.split(',').each do |track|
      self.tracks << Track.find(track)
    end
  end

  def self.grab_top(num)
    full_mix_down_array = []
    self.order("created_at DESC").limit(num).each do |mix_down|
      this_mix_down_hash = {}
      this_mix_down_hash[:mix_down_sc_id] = mix_down.sc_id
      this_mix_down_hash[:tracks] = mix_down.tracks.map {|track| track}
      full_mix_down_array << this_mix_down_hash
    end
    full_mix_down_array
  end

  def self.grab_by_instrument(instrument, limit)
    self.find_by_sql("
      SELECT mix_downs.sc_id, mix_downs.id FROM mix_downs
      INNER JOIN mix_down_tracks ON mix_down_tracks.mix_down_id = mix_downs.id
      INNER JOIN tracks ON mix_down_tracks.track_id = tracks.id
      INNER JOIN track_instruments ON track_instruments.track_id = tracks.id
      INNER JOIN instruments ON track_instruments.instrument_id = instruments.id
      WHERE instruments.name = '#{instrument}'
      GROUP BY mix_downs.id
      LIMIT #{limit}
    ")
  end
end
