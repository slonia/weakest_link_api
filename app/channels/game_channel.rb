class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "games"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
