class AddWinToHeroPicks < ActiveRecord::Migration[5.2]
  def change
    add_column :hero_picks, :win, :boolean
  end
end
