class Game < ApplicationRecord
  scope :running, -> { where(status: [:active, :preparation]) }
end
