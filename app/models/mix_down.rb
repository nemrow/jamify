class MixDown < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id, :description

  belongs_to :user
  belongs_to :project
  has_many :tracks, :through => :mix_down_tracks
  has_many :mix_down_tracks

  def add_bulk_tracks(track_array)
    track_array.split(',').each do |track|
      self.tracks << Track.find(track)
    end
  end

  def self.get_mix_downs_by_instrument(instrument, limit)
    mix_down_ids = MixDown.grab_by_instrument(instrument, limit)
    self.find(mix_down_ids.map{ |mix_down| mix_down.id }).map do |mix_down|
      tracks = mix_down.tracks.map {|track| track}
      user = mix_down.user
      mix_down.attributes.merge({:tracks => tracks, :user => user})
    end
  end

  def self.grab_top(num)
    self.order("created_at DESC").limit(num).map do |mix_down|
      tracks = mix_down.tracks.map {|track| track}
      mix_down.attributes.merge({:tracks => tracks})
    end
  end

  def self.grab_by_instrument(instrument, limit)
    self.find_by_sql("
      SELECT mix_downs.sc_id, mix_downs.id, mix_downs.user_id FROM mix_downs
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
