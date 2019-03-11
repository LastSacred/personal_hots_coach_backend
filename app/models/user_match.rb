class UserMatch < ApplicationRecord
  belongs_to :user
  belongs_to :match
  # TODO: git rid of this?
end
