class Rack::Attack
  ### Configure Cache ###
  ## Defaults to `Rails.cache`, but we'll use REDIS
  redis_client = Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" })
  Rack::Attack.cache.store = Rack::Attack::StoreProxy::RedisStoreProxy.new(redis_client)
  
  ### Throttle Spammy Clients ###
  ## We're setting a limit of 30rpm/IP for enpoints_array paths
  ## If using CDN, this will count it as that also
  endpoints_array = ["/", "/feeds" ]
  throttle("req/ip", :limit => 30, :period => 1.minute) do |req|
    req.ip if endpoints_array.include?(req.path)
  end

  ## Exponential backoff for all requests to root path
  ## Allows 160 requests in ~8 minutes
  ## 320 requests in ~1 hour
  ## 640 requests in ~8 hours (~1920 requests/day)
  (3..5).each do |level|
    throttle("req/ip/#{level}", :limit => (20 * (2 ** level)), :period => (0.9 * (8 ** level)).to_i.seconds) do |req|
      req.ip if endpoints_array.include?(req.path)
    end
  end

  ### Prevent Brute-Force Login, Signup, Feeds create Attacks ###
  ## Don't allow if user signs in/signs up 3 times in less than 15 mins
  throttle("users/sign_in", limit: 3, period: 15.minutes) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  throttle("users/sign_up", limit: 3, period: 15.minutes) do |req|
    req.ip if req.path == "/users" && req.post?
  end

  throttle("/feeds/create", limit: 3, period: 15.minutes) do |req|
    req.ip if req.path == "/feeds" && req.post?
  end

  ## Custom Throttled response for scrappers/hackers to see
  self.throttled_response = lambda do |env|
    [
      503,  # status
      {},   # headers
      [Message.ip_throttled_body] # body
    ]
  end
end


## Send the notification when a request is throttled
ActiveSupport::Notifications.subscribe('rack.attack') do |name, start, finish, request_id, payload|
  req = payload[:request]
  if %i[throttle].include?(req.env['rack.attack.match_type'])
    Rails.logger.info "[Rack::Attack][Blocked] - remote_ip: #{req.ip} - path: #{req.path}"
  end
end