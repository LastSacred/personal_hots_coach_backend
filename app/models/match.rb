class Match < ApplicationRecord
  belongs_to :map, optional: true
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  has_many :user_matches
  has_many :users, through: :user_matches

  def self.import(replay_path)
    
  end
end
