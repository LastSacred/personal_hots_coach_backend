class AddTrackQuickMatchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :track_quick_match, :boolean, default: false
  end
end
