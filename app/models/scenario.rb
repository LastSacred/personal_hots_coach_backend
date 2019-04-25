class Scenario
  attr_reader :score, :win_percent, :match_count

  def initialize(**params)
    @params = params
    get_matches
    @match_count = @matches.count
    get_scores
    @win_percent = @scores.count > 0 ? @scores.sum / @scores.count / 10 : nil
    fill_scores
    @score = @scores.sum / @scores.count
  end

  private

  def filter_by_hero(matches)
    hero = @params[:with_hero] if @params[:with_hero]
    hero = @params[:against_hero] if @params[:against_hero]
    return matches if !hero

    matches.select do |match|
      match.hero_picks.find do |hero_pick|
        hero_pick.hero == hero &&
        (
          (@params[:with_hero] && hero_pick.team == @params[:user].my_team(match)) ||
          (@params[:against_hero] && hero_pick.team != @params[:user].my_team(match))
        )
      end
    end
  end

  def get_matches
    return @matches = [] if @params[:draft]

    matches = @params[:user].tracked_matches.select { |match| @params[:user].my_pick(match).hero == @params[:as_hero] }
    matches = matches.select { |match| match.map == @params[:map] } if @params[:map]
    matches = filter_by_hero(matches)

    @matches = matches
  end

  def get_scores
    if @params[:draft]
      scores = []

      @params[:draft][:with_heroes].each do |hero|
        scores << Scenario.new(user: @params[:user], as_hero: @params[:as_hero], with_hero: hero, map: @params[:draft][:map]).score
      end

      @params[:draft][:against_heroes].each do |hero|
        scores << Scenario.new(user: @params[:user], as_hero: @params[:as_hero], against_hero: hero, map: @params[:draft][:map]).score
      end
    else
      scores = @matches.collect do |match|
        @params[:user].my_pick(match).win ? 1000 : 0
      end
    end

    @scores = scores
  end

  def fill_scores
    if @params[:draft]
      min = 4
      fill = Scenario.new(user: @params[:user], as_hero: @params[:as_hero], map: @params[:draft][:map]).score
    elsif @params[:map] && (@params[:with_hero] || @params[:against_hero])
      min = 5
      fill = Scenario.new(user: @params[:user], as_hero: @params[:as_hero], with_hero: @params[:with_hero]).score if @params[:with_hero]
      fill = Scenario.new(user: @params[:user], as_hero: @params[:as_hero], against_hero: @params[:against_hero]).score if @params[:against_hero]
    elsif @params[:map] || @params[:with_hero] || @params[:against_hero]
      min = 10
      fill = Scenario.new(user: @params[:user], as_hero: @params[:as_hero]).score
    else
      min = 50
      fill = 500
    end

    while @scores.count < min
      @scores << fill
    end
  end

end
