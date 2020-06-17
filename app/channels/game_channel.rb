class GameChannel < ApplicationCable::Channel
  def subscribed
    binding.pry
    key = Player.game_id(params[:id])
    stream_from key
    ActionCable.server.broadcast(key, {players: Player.for_game(params[:id])})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
