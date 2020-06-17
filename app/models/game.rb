class Game < ApplicationRecord
  class<<self
    def all
      redis.lrange('games', 0, redis.llen('games'))
    end

    def create(id)
      redis.rpush('games', id)
    end

    private

    def redis
      @redis ||= Redis.new
    end
  end
end
