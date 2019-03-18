class User < ApplicationRecord
  has_many :roster_listings
  has_many :heroes, through: :roster_listings
  has_many :replay_files
  has_many :matches, through: :replay_files
  has_secure_password

  validates :name, :battletag, uniqueness: true
  validates :name, :password_digest, :battletag, presence: true

  def roster=(hero_names)
    self.heroes = hero_names.map do |hero_name|
      Hero.find_by(name: hero_name)
    end
  end

  def my_matches
    Match.all.select do |match|
      my_pick(match)
    end
  end

  def tracked_matches
    # assigning tracked_matches to an instance variable made #score(:draft) 25 times faster
    @tracked_matches = @tracked_matches || self.my_matches.select do |match|
      match.complete &&
      match.game_type == "HeroLeague" &&
      match.game_date >= (Date.today - 90).strftime("%Y-%m-%d")
    end

    @tracked_matches
  end

  def roster
    return auto_heroes if self.auto_roster
    return self.heroes
  end

  def score(**params)
    matches = matches_as(params[:as_hero]) unless params[:draft]
    matches = filter_by_map(matches, params[:map]) if params[:map]
    matches = filter_by_hero(matches, :with, params[:with_hero]) if params[:with_hero]
    matches = filter_by_hero(matches, :against, params[:against_hero]) if params[:against_hero]

    if params[:draft]
      scores = []

      params[:draft][:with_heroes].each do |hero|
        scores << self.score(as_hero: params[:as_hero], with_hero: hero, map: params[:draft][:map])
      end

      params[:draft][:against_heroes].each do |hero|
        scores << self.score(as_hero: params[:as_hero], against_hero: hero, map: params[:draft][:map])
      end
    else
      scores = matches.collect do |match|
        my_pick(match).win ? 1000 : 0
      end
    end

    if params[:draft]
      min = 8
      fill = self.score(as_hero: params[:as_hero], map: params[:draft][:map])
    elsif params[:map] && (params[:with_hero] || params[:against_hero])
      min = 5
      fill = self.score(as_hero: params[:as_hero], with_hero: params[:with_hero]) if params[:with_hero]
      fill = self.score(as_hero: params[:as_hero], against_hero: params[:against_hero]) if params[:against_hero]
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

    scores.sum / scores.count
  end

  def pick_list(draft)
    list = self.roster.collect do |hero|
      {hero: hero, score: self.score(as_hero: hero, draft: draft)}
    end

    list.sort_by { |obj| obj[:score] }.reverse
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
        (
          (relationship == :with && hero_pick.team == my_team(match)) ||
          (relationship == :against && hero_pick.team != my_team(match))
        )
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
    roster = self.tracked_matches.collect do |match|
      hero_pick = match.hero_picks.find do |hero_pick|
        hero_pick.picked_by == self.battletag
      end

      hero_pick.hero
    end

    roster.uniq
  end

end
