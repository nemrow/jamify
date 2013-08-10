class CreateMixDownTracks < ActiveRecord::Migration
  def change
    create_table :mix_down_tracks do |t|
      t.integer :mix_down_id
      t.integer :track_id
      t.timestamps
    end
  end
end
