class StatSet
  attr_reader :hero, :score, :win_percent, :match_count, :best_with, :best_against, :best_on, :hero_sets

  def initialize(user, hero=nil)
    if !hero
      hero_sets = user.heroes.collect do |hero|
        StatSet.new(user, hero)
      end

      return @hero_sets = hero_sets.sort_by { |hero_set| hero_set.score }.reverse
    end

    @hero = hero

    scenario = Scenario.new(user: user, as_hero: @hero)

    @score = scenario.score
    @win_percent = scenario.win_percent
    @match_count = scenario.match_count
    @best_with = best(user, :with_hero)
    @best_against = best(user, :against_hero)
    @best_on = best(user, :map)
  end

  def best(user, target)
    if target == :map
      list = Map.actual.collect do |map|
        scenario = Scenario.new(user: user, as_hero: @hero, target => map)

        {
          map: map,
          score: scenario.score,
          win_percent: scenario.win_percent,
          match_count: scenario.match_count
        }
      end
    else
      list = Hero.all.collect do |hero|
        scenario = Scenario.new(user: user, as_hero: @hero, target => hero)

        {
          hero: hero,
          score: scenario.score,
          win_percent: scenario.win_percent,
          match_count: scenario.match_count
        }
      end
    end

    list.sort_by { |obj| obj[:score] }.reverse
  end
end
