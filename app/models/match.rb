class Match < ApplicationRecord
  belongs_to :map, optional: true
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  has_many :user_matches
  has_many :users, through: :user_matches

  def self.import(file_path)

  end

  def self.upload_replays(replay_path)
    Dir.glob(replay_path + "*.StormReplay") do |replay|
      next if Match.find_by(original_path: replay)

      match = Adapter.post_replay(replay)

      if match["status"] == "AiDetected"
        Match.find_or_create_by(original_path: replay)
      else
        Match.find_or_create_by(replay_id: match["id"]).update(original_path: replay)
      end
      
      sleep(1.5)
    end
  end

end
