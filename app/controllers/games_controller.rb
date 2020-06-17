class GamesController < ApplicationController
  def create
    Game.create(params[:id])
    broadcast_games
    render json: {status: :ok}
  end

  def join
    players = redis.rpush(params[:id], params[:player])
    broadcast_games
    render json: {status: :ok, players: players}
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
