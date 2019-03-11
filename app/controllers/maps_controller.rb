class MapsController < ApplicationController

  def index
    excluded = [
      "Braxis Outpost",
      "Checkpoint: Hanamura",
      "Escape From Braxis",
      "Industrial District",
      "Lost Cavern",
      "Pull Party",
      "Silver City",
    ]

    @maps = Map.all.reject do |map|
      excluded.include?(map.name)
    end

    render json: @maps.to_json, status: :ok
  end
end
