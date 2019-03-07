class User < ApplicationRecord
  has_many :user_matches
  has_many :roster_listings
  has_many :matches, through: :user_matches
  has_many :heroes, through: :roster_listings
  has_secure_password
end
