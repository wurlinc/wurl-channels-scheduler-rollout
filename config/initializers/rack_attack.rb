# See reference: https://github.com/kickstarter/rack-attack#throttling

# Killswitch:
unless ENV.fetch('DISABLE_RACK_ATTACK', 'false') == 'true'
  # If the request is from a safe-listed ip, no need to throttle:
  Rack::Attack.safelist("safelist ip") do |req|
    safelist_key_exists = Rails.cache.read("safelist_ip_#{req.ip}")

    # For now, IPs can be permanently safelisted from the ENV:
    permanent_safelist = ENV.fetch('PERMANENT_IP_SAFELIST', '').split(';')
    permanently_safelisted = !permanent_safelist.index(req.ip).nil?

    safelist_key_exists || permanently_safelisted
  end

  # Throttle requests from ips not on the Redis safelist:
  request_limit = proc { |req| req.get? ? ENV.fetch('RA_GET_REQUEST_LIMIT', 5).to_i : ENV.fetch('POST_REQUEST_LIMIT', 2).to_i }
  period_limit = ENV.fetch('RA_REQUEST_PERIOD', 1).to_i
  Rack::Attack.throttle("requests by ip", limit: request_limit, period: period_limit) do |req|
    req.ip
  end

  # Blocklist killswitch:
  unless ENV.fetch('DISABLE_RACK_ATTACK_BLOCKLIST', 'false') == 'true'
    # Lockout IP addresses that are hammering your login page.
    # After 20 requests in 1 minute, block all requests from that IP for 1 hour.
    Rack::Attack.blocklist('allow2ban login scrapers') do |req|
      # `filter` returns false value if request is to your login page (but still
      # increments the count) so request below the limit are not blocked until
      # they hit the limit.  At that point, filter will return true and block.
      Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 10, findtime: 1.minute, bantime: 1.hour) do
        # The count for the IP is incremented if the return value is truthy.
        req.path == '/login'
      end
    end
  end

  # You can also set a limit and period using a proc. For instance, after
  # Rack::Auth::Basic has authenticated the user:
  # limit_proc = proc { |req| req.env["REMOTE_USER"] == "admin" ? 100 : 1 }
  # period_proc = proc { |req| req.env["REMOTE_USER"] == "admin" ? 1 : 60 }
end