class RosterListing < ApplicationRecord
  belongs_to :user
  belongs_to :hero
end
