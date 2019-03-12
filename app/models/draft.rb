class Draft
  attr_reader :user, :map, :bans, :with_heroes, :against_heroes, :pick_list
  attr_writer :user, :pick_list

  def map=(map)
    @map = Map.find_by(name: map)
  end

  def bans=(bans)
    @bans = bans.collect do |ban|
      Hero.find_by(name: ban)
    end
  end

  def with_heroes=(with_heroes)
    @with_heroes = with_heroes.collect do |with_hero|
      Hero.find_by(name: with_hero)
    end
  end

  def against_heroes=(against_heroes)
    @against_heroes = against_heroes.collect do |against_hero|
      Hero.find_by(name: against_hero)
    end
  end

  def initialize(**props)
    self.map = props[:map]
    self.bans = props[:bans]
    self.with_heroes = props[:with_heroes]
    self.against_heroes = props[:against_heroes]
    # self.pick_list = 'hi'
  end

  # def set_pick_list
  #   scored_list = @user.roster.collect do |hero|
  #     {hero: hero, score: total_score(hero)}
  #   end
  #
  #   self.pick_list = scored_list.sort_by { |obj| obj.score }.reverse
  # end

  # def total_score(ashero)
  #   scores = scores_including_heroes_on_map(ashero)
  #
  #   while scores.count < 8 do
  #     scores << score_on_map(ashero)
  #   end
  #
  #   scores.sum / scores.count
  # end
  #
  # def scores_including_heroes_on_map(ashero)
  #   scores = []
  #
  #   @with_heroes.each do |otherhero|
  #     scores << score_on_map_including_hero_as_hero(otherhero, ashero, true)
  #   end
  #
  #   @agains_theroes.each do |otherhero|
  #     scores << score_on_map_including_hero_as_hero(otherhero, ashero, false)
  #   end
  #
  #   scores
  # end
  #
  # def score_including_hero_on_map(otherhero, ashero, teammate)
  #   scores = @user.matches_including_hero_on_map
  #
  #   while scores.length < 5
  #     scores << score_including_hero(otherhero, ashero, teammate)
  #   end
  #
  #   score.sum / score.count
  # end
end
