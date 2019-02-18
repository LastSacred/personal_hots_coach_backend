class CreateRosterListings < ActiveRecord::Migration[5.2]
  def change
    create_table :roster_listings do |t|
      t.references :user, foreign_key: true
      t.references :hero, foreign_key: true

      t.timestamps
    end
  end
end
