class CreateReplayFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :replay_files do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
