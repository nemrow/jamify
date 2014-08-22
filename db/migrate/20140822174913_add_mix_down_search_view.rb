class AddMixDownSearchView < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("

      CREATE VIEW mix_down_searches AS
      SELECT
        mix_downs.id AS searchable_id,
        'MixDown' AS searchable_type,
        mix_downs.description AS term
      FROM mix_downs

      UNION

      SELECT
        mix_downs.id AS searchable_id,
        'MixDown' AS searchable_type,
        mix_downs.name AS term
      FROM mix_downs

      UNION

      SELECT
        mix_downs.id AS searchable_id,
        'MixDown' AS searchable_type,
        tracks.name AS term
      FROM mix_downs
      JOIN mix_down_tracks ON mix_down_tracks.mix_down_id = mix_downs.id
      JOIN tracks ON tracks.id = mix_down_tracks.track_id

      UNION

      SELECT
        mix_downs.id AS searchable_id,
        'MixDown' AS searchable_type,
        instruments.name AS term
      FROM mix_downs
      JOIN mix_down_tracks ON mix_down_tracks.mix_down_id = mix_downs.id
      JOIN tracks ON tracks.id = mix_down_tracks.track_id
      JOIN track_instruments ON track_instruments.track_id = tracks.id
      JOIN instruments ON instruments.id = track_instruments.instrument_id

    ")
  end

  def down
    ActiveRecord::Base.connection.execute("
      DROP VIEW mix_down_searches
    ")
  end
end
