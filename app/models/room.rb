class Room < ApplicationRecord
  has_mamy :room_users
  has_many :users, through room_users
end
