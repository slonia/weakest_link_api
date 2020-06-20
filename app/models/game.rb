class Game < ApplicationRecord
  scope :running, -> { where(status: [:active, :preparation]) }
  has_many :players
end
