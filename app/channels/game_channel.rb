class GameChannel < ApplicationCable::Channel
  def subscribed
    key = "game_" + params[:id]
    game = Game.find_by(uuid: params[:id])
    stream_from key
    ActionCable.server.broadcast(key, {players: game.players.pluck(:name)})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
