if ENV["REDIS_PROVIDER"]
  $redis = Redis.new(url: ENV["REDIS_PROVIDER"])
end