class Match < ApplicationRecord
  belongs_to :map, optional: true
  has_many :hero_picks
  has_many :heroes, through: :hero_picks

  before_validation :format_date

  validates :original_path, presence: true
  with_options if: :is_complete? do |match|
    match.validates :replay_id, uniqueness: true, presence: true
    match.validates :game_date, :game_type, :map_id, presence: true
    match.validates :heroes, length: {is: 10}
  end

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
      !match.complete && match.replay_id
    end
  end

  def self.parse_matches
    self.incomplete_matches.each do |match|
      data = Adapter.get("replays/#{match.replay_id}")
      if !data["processed"]
        puts "skipping #{match.replay_id}"
        sleep (1.5)
        next
      end

      match.update(
        game_date: data["game_date"],
        game_type: data["game_type"],
        map: Map.find_by(name: data["game_map"])
      )

      HeroPick.match_picks(match, data["players"])

      match.update(complete: true)

      puts "processed #{match.replay_id} #{match.complete}"

      sleep(1.5)
    end
  end

  def format_date
    self.game_date = self.game_date[0..9] if self.game_date
  end

  def is_complete?
    self.complete
  end

end
