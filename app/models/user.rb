class User < ApplicationRecord
  # has_many :user_matches
  has_many :roster_listings
  # has_many :matches, through: :user_matches
  has_many :heroes, through: :roster_listings
  has_secure_password

  validates :name, :battletag, uniqueness: true
  validates :name, :password_digest, :battletag, presence: true

  def roster=(hero_names)
    self.heroes = hero_names.map do |hero_name|
      Hero.find_by(name: hero_name)
    end
  end

  def matches
    Match.all.select do |match|
      match.hero_picks.find { |hero_pick| hero_pick.picked_by == self.battletag }
    end
  end

  def tracked_matches
    self.matches.select do |match|
      match.complete &&
      match.game_type == "HeroLeague" &&
      match.game_date >= (Date.today - 90).strftime("%Y-%m-%d")
    end

  end

  def roster
    return auto_heroes if self.auto_roster
    return self.heroes
  end

  private

  def auto_heroes
    self.tracked_matches.collect do |match|
      hero_pick = match.hero_picks.find do |hero_pick|
        hero_pick.picked_by == self.battletag
      end

      hero_pick.hero
    end
  end

end
