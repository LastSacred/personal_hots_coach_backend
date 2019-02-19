class Hero < ApplicationRecord
  has_many :hero_picks
  has_many :roster_listings
  has_many :matches, through: :hero_picks
  has_many :users, through: :roster_listings

  before_validation :format_role

  def self.import
    Adapter.get("heroes").each do |hero|
      self.find_or_create_by(name: hero["name"]).update(role: hero["role"])
    end
  end

  private

  def format_role
    if self.role
      self.role = self.role.upcase[0..3]
    end
  end

end
