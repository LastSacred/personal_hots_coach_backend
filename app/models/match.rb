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
    status = {}

    Map.import
    Hero.import
    status.merge(self.upload_replays(replay_path, user)) if replay_path

    count = 0
    while self.incomplete.present? && count < 2
      status.merge(self.parse_matches)
      status.merge(user.fix_battletags) if user
      count += 1
    end

    status.each do |replay_id, value|
      puts "#{replay_id}: #{value}"
    end

    puts "#{self.incomplete.count} incomplete matches" if self.incomplete.present?
  end

  def self.upload_replays(replay_path, user=nil)
    status = {}

    Dir.glob(replay_path + "*.StormReplay") do |replay|
      file_name = replay.split("/").last

      next if user && user.replay_files.find { |replay_file| replay_file.name == file_name }
      next if !user && self.find_by(original_path: replay)

      match_data = Adapter.post_replay(replay)
      replay_id = (match_data["status"] == "AiDetected" ? nil : match_data["id"])

      if match = Match.find_by(replay_id: replay_id)
        status[match.replay_id] = "associated with user"
      else
        match = Match.create(replay_id: replay_id)
        status[match.replay_id] = "uploaded"
      end

      match.update(original_path: replay)

      ReplayFile.find_or_create_by( name: file_name, user: user, match: match) if user

      status[match.replay_id] = 'uploaded'

      sleep(1.5)
    end

    status
  end

  private

  def self.incomplete
    self.all.select do |match|
      !match.complete && match.replay_id
    end
  end

  def self.parse_matches
    status = {}

    self.incomplete.each do |match|
      data = Adapter.get("replays/#{match.replay_id}")
      # TODO: take out the manual StormLeague if hots api fixes the problem with it coming in as nil
      match.update(
        game_date: data["game_date"],
        game_type: data["game_type"] || "StormLeague",
        map: Map.find_by(name: data["game_map"])
      )

      HeroPick.match_picks(match, data["players"])

      if data["processed"]
        match.update(complete: true)
        status[match.replay_id] = 'parsed'
      else
        status[match.replay_id] = 'incomplete'
        # this line is also here to fix the issue with StormLeague matches not processing
        status[match.replay_id] = 'parsed' if match.game_type == "StormLeague" && match.update(complete: true)
      end

      status[match.replay_id] = match.errors.full_messages if match.errors.full_messages.present?

      sleep(1.5)
    end

    status
  end

  def format_date
    self.game_date = self.game_date[0..9] if self.game_date
  end

  def is_complete?
    self.complete
  end

end
