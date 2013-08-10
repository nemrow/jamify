class CreateTrackInstruments < ActiveRecord::Migration
  def change
    create_table :track_instruments do |t|
      t.integer :track_id
      t.integer :instrument_id
      t.timestamps
    end
  end
end
