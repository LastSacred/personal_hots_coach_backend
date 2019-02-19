class Map < ApplicationRecord
  has_many :matches

  def self.import
    Import.maps.collect do |map|
      self.find_or_create_by(name: map["name"]).name
    end
  end

end
