class CreateHeroPicks < ActiveRecord::Migration[5.2]
  def change
    create_table :hero_picks do |t|
      t.string :picked_by
      t.integer :team
      t.references :match, foreign_key: true
      t.references :hero, foreign_key: true

      t.timestamps
    end
  end
end
