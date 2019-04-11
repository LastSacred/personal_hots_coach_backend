class AddTrackRankedDraftToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :track_ranked_draft, :boolean, default: true
  end
end
