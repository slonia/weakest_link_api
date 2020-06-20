class Player < ApplicationRecord
  belongs_to :game
  validate :name, uniqueness: { scope: :game_id }
end
