CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:      ENV['AWS_ACCESS_KEY'],                        # required
      aws_secret_access_key:  ENV['AWS_SECRET_KEY'],                        # required
      region: ENV['AWS_REGION']
  }

  config.fog_public     = false                                        # optional, defaults to true
  config.fog_authenticated_url_expiration = 1.hour
  config.fog_directory    = ENV['AWS_S3_BUCKET_NAME']
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
