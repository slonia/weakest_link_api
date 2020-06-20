class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy, :join]

  def index
    @games = Game.running

    render json: @games
  end

  def join
    if !@game.players.pluck(:name).include?(params[:name])
      @player = Player.create(name: params[:name], role: :player, game_id: @game.id)
    end
    ActionCable.server.broadcast("game_#{@game.uuid}", {players: @game.players.pluck(:name)})
    render json: { game: @game, players: @game.players}
  end

  def show
    render json: { game: @game, players: @game.players}
  end

  def create
    @game = Game.create(game_params)
    @player = Player.create(player_params.merge(game_id: @game.id, role: :creator))
    if @game.persisted? && @player.persisted?
      ActionCable.server.broadcast("games", {games: Game.pluck(:uuid)})
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find_by(id: params[:id]) || Game.find_by(uuid: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:uuid)
    end

    def player_params
      params.require(:game).permit(:name)
    end
end
