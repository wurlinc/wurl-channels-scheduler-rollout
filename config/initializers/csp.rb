SecureHeaders::Configuration.default do |config|

  _common_config = {
    # report_only: Rails.env.production?, # for the Content-Security-Policy-Report-Only header

  }

  config.cookies = SecureHeaders::OPT_OUT
  
  # Development
  DEV_SERVERS = %w(
                  http://platform.wurl.com:3000
                  http://platform.wurl.com:3001
                  http://platform.wurl.com:8080
                  http://localhost:8080
                  http://localhost:3000
                  http://localhost:3001
                  ws://localhost:3000
                  ws://localhost:3001
                  ws://localhost:8080
                  ws://platform.wurl.com:3000
                  ws://platform.wurl.com:3001
                  ws://platform.wurl.com:8080
                )
  config.csp = _common_config.merge({
    preserve_schemes: false, # Remove schemes from host sources
    default_src: DEV_SERVERS.concat(%w(*)), # all allowed in the beginning
    # script_src: %w('self' 'unsafe-eval' d2wy8f7a9ursnm.cloudfront.net), # scripts only allowed in external files from the same origin and from https://d2wy8f7a9ursnm.cloudfront.net/bugsnag-3.min.js
    script_src: DEV_SERVERS.concat(%w('self' 'unsafe-eval' 'unsafe-inline' webpack www.googletagmanager.com www.google-analytics.com d2wy8f7a9ursnm.cloudfront.net localhost:8080 platform.wurl.com:3000 platform.wurl.com:8080 platform-staging-assets.wurl.com platform-development-assets.wurl.com).concat([
      'platform.wurl.com', 'platform-staging.wurl.com', 'platform-development.wurl.com', ENV['CLOUDFRONT_HOST'], ENV['WURL_HOST'], 'platform-staging-assets.wurl.com', 'platform-development-assets.wurl.com', 'ws://platform.wurl.com:3000', 'platform.wurl.com:3001' ])), # scripts only allowed in external files from the same origin and from https://d2wy8f7a9ursnm.cloudfront.net/bugsnag-3.min.js
    # m3u8s are read as Ajax.
    connect_src: DEV_SERVERS.concat(["'self'", 'platform.wurl.com', 'platform-staging.wurl.com', 'platform-development.wurl.com', ENV['CLOUDFRONT_HOST'], "blob:", ENV["WURL_HOST"], "s3.amazonaws.com", "localhost:8080", "ws://localhost:3000", "ws://localhost:8080", "platform.wurl.com:8080", "ws://platform.wurl.com:8080", "platform.wurl.com:3000", "platform-staging-assets.wurl.com", "platform-development-assets.wurl.com", "ws://platform.wurl.com:3000", "platform.wurl.com:3001"]),
    # style_src: %w('self' 'unsafe-inline' *), # styles only allowed in external files from the same origin and in style attributes (for now) // 'self' 'unsafe-inline‘
    style_src: DEV_SERVERS.concat(%w('self' 'unsafe-inline' *)), # styles only allowed in external files from the same origin and in style attributes (for now) // 'self' 'unsafe-inline‘
    media_src: DEV_SERVERS.concat(['platform-staging-assets.wurl.com', 'platform-development-assets.wurl.com', 'platform.wurl.com', 'platform-staging.wurl.com', 'platform-development.wurl.com', ENV['CLOUDFRONT_HOST'], ENV['WURL_HOST'], "blob:", "s3.amazonaws.com", "platform.wurl.com:3000", 'ws://platform.wurl.com:3001', 'platform.wurl.com:3001']),
    worker_src:DEV_SERVERS.concat(%w('self' blob:).concat([ ENV['CLOUDFRONT_HOST'], ENV['WURL_HOST'], 'platform-staging-assets.wurl.com', 'platform-development-assets.wurl.com' ])),
    object_src: DEV_SERVERS.concat(%w('self').concat([ ENV['CLOUDFRONT_HOST'], ENV['WURL_HOST'], 'platform-staging-assets.wurl.com', 'platform-development-assets.wurl.com' ])),
    img_src: DEV_SERVERS.concat(%w('self'
    data: static0.channels.com
    static0.channels.com static1.channels.com static2.channels.com static3.channels.com static4.channels.com
    static5.channels.com static6.channels.com static7.channels.com static8.channels.com static9.channels.com
    s3.amazonaws.com wurl-channels.s3.amazonaws.com dki01q1l7yn3y.cloudfront.net
    *).concat([ 'platform.wurl.com', 'platform-staging.wurl.com', 'platform-development.wurl.com', ENV['CLOUDFRONT_HOST'], ENV['WURL_HOST'] ])), # HACK - allow images from anywhere right now. Remove asterisk after verifying it does not happen.
    # TODO Make controller to receive report_uri and send to bugsnag with the info
    # report_uri: ["/csp_report?report_only=#{Rails.env.production?}"] # violation reports will be sent here

  })
end
