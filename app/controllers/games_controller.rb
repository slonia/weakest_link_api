class GamesController < ApplicationController
  def create
    Game.create(params[:id])
    broadcast_games
    render json: {status: :ok, game: params[:id]}
  end

  def join
    key = Player.game_id(params[:id])
    Player.add_to_game(params[:id], SecureRandom.uuid)
    broadcast_games
    ActionCable.server.broadcast(key, {players: Player.for_game(params[:id])})
    render json: {status: :ok}
  end

  def show
    players = redis.lrange('players', 0, redis.llen('players'))
    render json: {status: :ok, players: players }
  end

  private

    def broadcast_games
      ActionCable.server.broadcast("games", {games: Game.all})
    end

end
