class CreateMixDowns < ActiveRecord::Migration
  def change
    create_table :mix_downs do |t|
      t.string :name
      t.integer :user_id
      t.integer :project_id
      t.integer :sc_id
      t.text :description
      t.timestamps
    end
  end
end
