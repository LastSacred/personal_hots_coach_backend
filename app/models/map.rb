class Map < ApplicationRecord
  has_many :matches

  def self.import
    Adapter.get("maps").each do |map|
      new_map = self.find_or_create_by(name: map["name"])
    end
  end

  def self.actual
    excluded = [
      "Braxis Outpost",
      "Checkpoint: Hanamura",
      "Escape From Braxis",
      "Industrial District",
      "Lost Cavern",
      "Pull Party",
      "Silver City",
    ]

    Map.all.reject do |map|
      excluded.include?(map.name)
    end
  end

end
