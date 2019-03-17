class HeroPick < ApplicationRecord
  belongs_to :match
  belongs_to :hero

  validates :team, :picked_by, presence: true

  def self.match_picks(match, players)
    match.hero_picks.each { |hero_pick| hero_pick.delete }

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
