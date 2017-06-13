if Rails.env.test?
  require "fakeredis"

  redis_conn = proc {
    Redis.new
  }
  Sidekiq.configure_client do |config|
    config.redis = ConnectionPool.new(size: 5, &redis_conn)
  end
  Sidekiq.configure_server do |config|
    config.redis = ConnectionPool.new(size: 25, &redis_conn)
  end
else
  config_file = "config/redis.yml"
  redis_conf = YAML.load_file(config_file)
  redis_conn = proc {
    Redis.new(redis_conf[ENV['RAILS_ENV']] || {})
  }
  Sidekiq.configure_client do |config|
    config.redis = ConnectionPool.new(size: 5, &redis_conn)
  end
  Sidekiq.configure_server do |config|
    # config.server_middleware do |chain|
    #   chain.remove Sidekiq::Middleware::Server::RetryJobs
    # end
    config.redis = ConnectionPool.new(size: 25, &redis_conn)
  end

end


