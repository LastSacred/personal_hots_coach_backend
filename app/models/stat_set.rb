class StatSet
  attr_reader :user, :hero, :score, :win_percent, :match_count, :best_with, :best_against, :best_on, :hero_sets

  def initialize(user, hero=nil)
    @user = user

    if !hero
      return @hero_sets = user.heroes.collect do |hero|
        StatSet.new(@user, hero)
      end
    end

    @hero = hero

    scenario = Scenario.new(user: @user, as_hero: @hero)

    @score = scenario.score
    @win_percent = scenario.win_percent
    @match_count = scenario.match_count
    @best_with = best(:with_hero)
    @best_against = best(:against_hero)
    @best_on = best(:map)
  end

  def best(target)
    if target == :map
      list = Map.actual.collect do |map|
        scenario = Scenario.new(user: @user, as_hero: @hero, target => map)

        {
          map: map,
          score: scenario.score,
          win_percent: scenario.win_percent,
          match_count: scenario.match_count
        }
      end
    else
      list = Hero.all.collect do |hero|
        scenario = Scenario.new(user: @user, as_hero: @hero, target => hero)

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
