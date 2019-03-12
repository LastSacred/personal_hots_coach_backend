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
      my_pick(match)
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

  def score(**params)
    matches = matches_as(params[:as_hero])
    matches = filter_by_map(matches, params[:map]) if params[:map]
    matches = filter_by_hero(matches, :with, params[:with_hero]) if params[:with_hero]
    matches = filter_by_hero(matches, :against, params[:against_hero]) if params[:against_hero]

    scores = matches.collect do |match|
      my_pick(match).win ? 1000 : 0
    end

    if params[:map] && (params[:with_hero] || params[:against_hero])
      return
    elsif params[:map] || params[:with_hero] || params[:against_hero]
      min = 10
      fill = self.score(as_hero: params[:as_hero])
    else
      min = 50
      fill = 500
    end

    while scores.count < min
      scores << fill
    end
    # byebug
    scores.sum / scores.count
  end

  private

  def matches_as(hero)
    self.tracked_matches.select do |match|
      my_pick(match).hero == hero
    end
  end

  def filter_by_map(matches, map)
    matches.select do |match|
      match.map == map
    end
  end

  def filter_by_hero(matches, relationship, hero)
    matches.select do |match|
      match.hero_picks.find do |hero_pick|
        hero_pick.hero == hero &&
        (relationship == :with && hero_pick.team == my_team(match)) ||
        (relationship == :against && hero_pick.team != my_team(match))
      end
    end
  end

  def my_team(match)
    my_pick(match).team
  end

  def my_pick(match)
    match.hero_picks.find{ |hero_pick| hero_pick.picked_by == self.battletag }
  end

  def auto_heroes
    self.tracked_matches.collect do |match|
      hero_pick = match.hero_picks.find do |hero_pick|
        hero_pick.picked_by == self.battletag
      end

      hero_pick.hero
    end
  end

end
