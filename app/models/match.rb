class Match < ApplicationRecord
  belongs_to :map, optional: true
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  has_many :user_matches
  has_many :users, through: :user_matches

  def self.import(replay_path)
    Map.import
    Hero.import
    self.upload_replays(replay_path)

    count = 0

    while self.incomplete_matches.present? && count <= 5
      self.parse_matches
      count += 1
    end
  end

  def self.upload_replays(replay_path)
    Dir.glob(replay_path + "*.StormReplay") do |replay|
      next if self.find_by(original_path: replay)

      match = Adapter.post_replay(replay)

      if match["status"] == "AiDetected"
        self.find_or_create_by(original_path: replay)
      else
        self.find_or_create_by(replay_id: match["id"]).update(original_path: replay)
      end

      sleep(1.5)
    end
  end

  private

  def self.incomplete_matches
    self.all.select do |match|
      !match.game_date || match.replay_id
    end
  end

  def self.parse_matches
    self.incomplete_matches.each do |match|
      next if match.game_date || !match.replay_id

      data = Adapter.get("replays/#{match.replay_id}")

      next if !data["processed"]

      match.update(
        game_date: data["game_date"],
        game_type: data["game_type"],
        map: Match.find_by(name: data["game_map"]),
        hero_picks: HeroPick.match_picks(data["players"])
      )
    end
  end

end
