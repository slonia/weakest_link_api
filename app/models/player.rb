class Player < ApplicationRecord
  belongs_to :game
  validates :name, uniqueness: { scope: :game_id }
  scope :regular, -> { where(role: :player) }
end
