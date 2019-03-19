class Match < ApplicationRecord
  belongs_to :map, optional: true
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  has_many :replay_files
  has_many :users, through: :replay_files

  before_validation :format_date

  validates :replay_id, uniqueness: true, allow_nil: true
  with_options if: :is_complete? do |match|
    match.validates :replay_id, :game_date, :game_type, :map_id, presence: true
    match.validates :heroes, length: {is: 10}
  end

  def self.import(replay_path=nil, user=nil)
    Map.import
    Hero.import
    self.upload_replays(replay_path, user) if replay_path

    count = 0
    while self.incomplete.present? && count < 2
      self.parse_matches
      count += 1
    end

    user.fix_battletags if user
  end

  def self.upload_replays(replay_path, user=nil)
    Dir.glob(replay_path + "*.StormReplay") do |replay|
      file_name = replay.split("/").last

      next if user && user.replay_files.find { |replay_file| replay_file.name == file_name }
      next if !user && self.find_by(original_path: replay)

      match_data = Adapter.post_replay(replay)
      replay_id = (match_data["status"] == "AiDetected" ? nil : match_data["id"])
      match = Match.find_or_create_by(replay_id: replay_id)
      match.update(original_path: replay)

      ReplayFile.find_or_create_by( name: file_name, user: user, match: match) if user

      sleep(1.5)
    end
  end

  private

  def self.incomplete
    self.all.select do |match|
      !match.complete && match.replay_id
    end
  end

  def self.parse_matches
    self.incomplete.each do |match|
      data = Adapter.get("replays/#{match.replay_id}")
      ## I will put this back in if there are any errors caused by incomplete replays
      # if !data["processed"]
      #   puts "skipping #{match.replay_id}"
      #   sleep (1.5)
      #   next
      # end

      match.update(
        game_date: data["game_date"],
        game_type: data["game_type"],
        map: Map.find_by(name: data["game_map"])
      )

      HeroPick.match_picks(match, data["players"])

      (data["processed"]) ? (match.update(complete: true)) : (puts "check #{match.replay_id}")

      if match.errors.full_messages.present?
        puts match.errors.full_messages
        byebug
      end
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
