class Player < ApplicationRecord
  class<<self
    def for_game(id)
      redis.lrange(game_id(id), 0, redis.llen(game_id(id)))
    end

    def add_to_game(id, player)
      redis.rpush(game_id(id), player)
    end

    def game_id(id)
      "game_#{id}"
    end

    private

    def redis
      @redis ||= Redis.new
    end

  end
end
