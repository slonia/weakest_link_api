class GameChannel < ApplicationCable::Channel
  def subscribed
    key = "game_" + params[:id]
    game = Game.find_by(uuid: params[:id])
    stream_from key
    ActionCable.server.broadcast(key, {event: "player_joined", data: {players: game.players.regular.pluck(:name)}})
  end

  def receive(data)
    key = "game_" + params[:id]
    game = Game.find_by(uuid: params[:id])
    if data['event'] == 'question'
      question = Question.order("RANDOM()").last
      data['question'] = question.text
      data['answer'] = question.answer
    end
    ActionCable.server.broadcast(key, data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
