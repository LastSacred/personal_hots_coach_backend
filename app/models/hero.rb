class Hero < ApplicationRecord
  has_many :hero_picks
  has_many :roster_listings
  has_many :matches, through: :hero_picks
  has_many :users, through: :roster_listings

  before_validation :format_role

  validates :name, uniqueness: true
  # TODO: write method to update a hero if it has changed
  def self.import
    Adapter.get("heroes").each do |hero|
      self.find_or_create_by(
        name: hero["name"],
        role: hero["role"],
        icon_url: hero["icon_url"]["92x93"]
      )
    end
  end

  private

  def format_role
    if self.role
      self.role = self.role.upcase[0..3]
    end
  end

end
