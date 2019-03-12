class Draft
  attr_reader :user, :map, :bans, :with_heroes, :against_heroes, :pick_list
  attr_writer :user

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

  def initialize(props={})
    self.map = props[:map]
    self.bans = props[:bans]
    self.with_heroes = props[:with_heroes]
    self.against_heroes = props[:against_heroes]
  end
  # TODO: write test for set_pick_list
  def set_pick_list
    draft = {map: @map, with_heroes: @with_heroes, against_heroes: @against_heroes}

    list = @user.roster.collect do |hero|
      {hero: hero, score: @user.score(as_hero: hero, draft: draft)}
    end

    @pick_list = list.sort_by { |obj| obj[:score] }.reverse
  end
end
