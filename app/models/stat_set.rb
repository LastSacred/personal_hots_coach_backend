class StatSet
  attr_reader :user, :hero, :total_score, :total_win_percent, :match_count, :best_with, :best_against, :best_on

  def initialize(user, hero)
    @user = user
    @hero = hero
    @total_score = @user.score(as_hero: @hero)
    @total_win_percent = 'win%'
    @match_count = 'match#'
    @best_with = best(:with_hero)
    @best_against = best(:against_hero)
    @best_on = best(:map)
  end

  def best(target)
    if target == :map
      list = Map.actual.collect do |map|
        {
          map: map,
          score: @user.score(as_hero: @hero, target => map)
        }
      end
    else
      list = Hero.all.collect do |hero|
        {
          hero: hero,
          score: @user.score(as_hero: @hero, target => hero)
        }
      end
    end

    list.sort_by { |obj| obj[:score] }.reverse
  end

end
