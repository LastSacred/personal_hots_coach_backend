class AddTrackUnrankedDraftToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :track_unranked_draft, :boolean, default: true
  end
end
