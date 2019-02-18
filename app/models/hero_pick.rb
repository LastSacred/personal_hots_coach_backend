class HeroPick < ApplicationRecord
  belongs_to :match
  belongs_to :hero
end
