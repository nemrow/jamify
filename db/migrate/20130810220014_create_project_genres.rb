class CreateProjectGenres < ActiveRecord::Migration
  def change
    create_table :project_genres do |t|
      t.integer :project_id
      t.integer :genre_id
      t.timestamps
    end
  end
end
