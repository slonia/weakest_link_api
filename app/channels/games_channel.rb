class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "games"
    ActionCable.server.broadcast("games", {games: Game.pluck(:uuid)})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
