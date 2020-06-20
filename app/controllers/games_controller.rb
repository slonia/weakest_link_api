class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  def index
    @games = Game.running

    render json: @games
  end

  def show
    render json: @game
  end

  def create
    @game = Game.new(game_params)

    if @game.save
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
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:uuid)
    end
end
