class RemoveWinnerFromMatches < ActiveRecord::Migration[5.2]
  def change
    remove_column :matches, :winner, :integer
  end
end
