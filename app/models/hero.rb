class Hero < ApplicationRecord
  has_many :hero_picks
  has_many :roster_listings
  has_many :matches, through: :hero_picks
  has_many :users, through: :roster_listings
end
