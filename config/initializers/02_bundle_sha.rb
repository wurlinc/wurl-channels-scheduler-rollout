path = "public/webpack/main-bundle.js"

Rails.logger.info("Setting WEBPACK_BUNDLE_SHA for #{path}")

bundle_sha = Pathname.new(path).exist? ? Digest::SHA256.file(path) : ''

Rails.logger.info("Here's the main-bundle.js SHA: #{bundle_sha}")

ENV['WEBPACK_BUNDLE_SHA'] = bundle_sha.to_s
