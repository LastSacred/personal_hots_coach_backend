class AddIconUrlToHeroes < ActiveRecord::Migration[5.2]
  def change
    add_column :heroes, :icon_url, :string
  end
end
