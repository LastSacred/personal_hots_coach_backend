class User < ApplicationRecord
  has_many :roster_listings
  has_many :heroes, through: :roster_listings
  has_many :replay_files
  has_many :matches, through: :replay_files
  has_secure_password

  validates :name, :battletag, uniqueness: true
  validates :name, :password_digest, :battletag, presence: true

  def import
    Match.import(self.replay_path, self)
  end

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
      match.game_date >= (Date.today - 90).strftime("%Y-%m-%d") &&
      (self.track_quick_match || match.game_type != 'QuickMatch') &&
      (self.track_unranked_draft || match.game_type != 'UnrankedDraft') &&
      (self.track_ranked_draft || !match.game_type.include?('League')) &&
      match.complete
    end

    @tracked_matches
  end

  def roster
    return auto_heroes if self.auto_roster
    return self.heroes
  end

  def pick_list(draft)
    list = self.roster.collect do |hero|
      {hero: hero, score: Scenario.new(user: self, as_hero: hero, draft: draft).score}
    end

    list.sort_by { |obj| obj[:score] }.reverse
  end

  def fix_battletags
    status = {}

    Match.all.each do |match|
      hero_pick = match.hero_picks.find do |hero_pick|
        hero_pick.picked_by == self.battletag.split('#').first
      end

      if hero_pick
        hero_pick.update(picked_by: self.battletag)
        match.update(complete: true)

        status[match.replay_id] = "parsed (fixed battletag)"
        status[match.replay_id] = match.errors.full_messages if match.errors.full_messages.present?
      end
    end

    status
  end

  def my_team(match)
    my_pick(match).team
  end

  def my_pick(match)
    match.hero_picks.find{ |hero_pick| hero_pick.picked_by == self.battletag }
  end

  private

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
