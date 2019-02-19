class Map < ApplicationRecord
  has_many :matches

  def self.import
    Adapter.get("maps").each do |map|
      new_map = self.find_or_create_by(name: map["name"])
    end
  end

end
