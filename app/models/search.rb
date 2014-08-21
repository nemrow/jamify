class Search
  def self.all_mix_downs_containing_keywords(keyword, limit)
    MixDown.where(:id => Search.all_mix_down_ids_with_keywords(keyword)).limit(limit).map do |mix_down|
      mix_down.build_data_hash
    end
  end

  def self.all_mix_down_ids_with_keywords(keyword)
    ActiveRecord::Base.connection.select_values("
      select md.id
      from instruments i
      join track_instruments ti on (ti.instrument_id = i.id)
      join mix_down_tracks mdt on (mdt.track_id = ti.track_id)
      join tracks t on (t.id = ti.track_id)
      join mix_downs md on (md.id = mdt.mix_down_id)
      where md.description like '%#{keyword}%'
      or md.name like '%#{keyword}%'
      or i.name like '%#{keyword}%'
    ").uniq
  end
end