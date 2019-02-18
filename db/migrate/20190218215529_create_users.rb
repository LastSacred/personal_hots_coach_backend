class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :battletag
      t.string :replay_path
      t.boolean :auto_roster, default: true

      t.timestamps
    end
  end
end
