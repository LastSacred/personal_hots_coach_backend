class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :winner
      t.integer :replay_id
      t.string :game_date
      t.string :original_path
      t.string :game_type
      t.references :map, foreign_key: true

      t.timestamps
    end
  end
end
