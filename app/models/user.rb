class User < ApplicationRecord
  has_many :user_matches
  has_many :roster_listings
  has_many :matches, through: :user_matches
  has_many :heroes, through: :roster_listings
  has_secure_password

  validates :name, :battletag, uniqueness: true
  validates :name, :password, :battletag, presence: true

  def roster=(hero_names)
    self.heroes = hero_names.map do |hero_name|
      Hero.find_by(name: hero_name)
    end
  end
end
