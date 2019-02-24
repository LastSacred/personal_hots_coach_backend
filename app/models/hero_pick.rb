class HeroPick < ApplicationRecord
  belongs_to :match
  belongs_to :hero

  validates :team, :picked_by, presence: true
  validates :hero, uniqueness: {scope: :match}

  def self.match_picks(match, players)
    players.collect do |player|
      self.create(
        hero: Hero.find_by(name: player["hero"]),
        match: match,
        team: player["team"],
        win: player["winner"],
        picked_by: player["battletag"]
      )
    end
  end
end
