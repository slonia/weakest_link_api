class GamesController < ApplicationController
  def index
    begin
      games = redis.lrange('games', 0, redis.llen('games'))
      render json: {status: :ok, games: games}
    end
  end

  def create
    games = redis.rpush('games', params[:id])
    redis.rpush(params[:id], 'author')
    ActionCable.server.broadcast("games", {message: "hello ws"})
    render json: {status: :ok, games: games}
  end

  def join
    players = redis.rpush(params[:id], params[:player])
    ActionCable.server.broadcast("games", {message: "hello ws", players: players})
    render json: {status: :ok, players: players}
  end

  def show
    players = redis.lrange('players', 0, redis.llen('players'))
    render json: {status: :ok, players: players }
  end

  private

    def redis
      @redis ||= Redis.new
    end
end
