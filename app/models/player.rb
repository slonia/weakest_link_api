class Game < ApplicationRecord
  class<<self
    def for_game(id)
      redis.lrange(key(id), 0, redis.llen(key(id)))
    end

    def add_to_game(id, player)
      redis.rpush(key(id), player)
    end

    private

    def redis
      @redis ||= Redis.new
    end

    def key(id)
      "game_#{id}"
    end
  end
end
