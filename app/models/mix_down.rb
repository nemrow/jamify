class MixDown < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id, :description

  belongs_to :user
  belongs_to :project
  has_many :tracks, :through => :mix_down_tracks
  has_many :mix_down_tracks
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  def add_bulk_tracks(track_array)
    track_array.split(',').each do |track|
      self.tracks << Track.find(track)
    end
  end

  def self.get_mix_downs_by_instrument(instrument, limit)
    mix_down_ids = MixDown.grab_by_instrument(instrument, limit)
    mix_downs_sorted_by_ids(mix_down_ids).map do |mix_down|
      mix_down.build_data_hash
    end
  end

  def self.mix_downs_sorted_by_ids(mix_down_ids)
    self.find(mix_down_ids.map{ |mix_down| mix_down.id }).sort_by{|mix_down| mix_down.updated_at}.reverse
  end

  def build_data_hash
    self.attributes.merge(
      {
        :tracks => self.tracks.order("updated_at DESC").map {|track| track},
        :user => self.user,
        :comments => self.comments,
        :collaborators => self.collaborators,
        :like_count => self.likes.count,
        :instruments => MixDown.get_all_instruments_in_mix_down(self)
      }
    )
  end

  def self.get_all_instruments_in_mix_down(mix_down)
    ActiveRecord::Base.connection.select_all("
      select i.id from instruments i
      join track_instruments ti on (ti.instrument_id = i.id)
      join mix_down_tracks mdt on (mdt.track_id = ti.track_id)
      where mdt.mix_down_id = #{mix_down.id}
    ").map do |instrument_hash|
      Instrument.find(instrument_hash['id'])
    end
  end

  def collaborators
    self.tracks.map do |track|
      track.user
    end
  end

  def self.grab_top(num)
    self.order("created_at DESC").limit(num).map do |mix_down|
      mix_down.build_data_hash
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
