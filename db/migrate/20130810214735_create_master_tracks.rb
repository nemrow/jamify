class CreateMasterTracks < ActiveRecord::Migration
  def change
    create_table :master_tracks do |t|
      t.string :name
      t.integer :user_id
      t.integer :project_id
      t.integer :sc_id
      t.timestamps
    end
  end
end
