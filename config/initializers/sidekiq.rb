if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'],
                     network_timeout: 5 }

    # config.server_middleware do |chain|
    #   chain.add Sidekiq::Middleware::Server::SentryErrorLogger
    # end

    config.server_middleware do |chain|
      chain.add Sidekiq::Middleware::Server::RetryJobs, :max_retries => 0
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'],
                     network_timeout: 5 }
  end
end
