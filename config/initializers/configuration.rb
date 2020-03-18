# Validate Configuration so we can fail fast if values are missing.

require 'active_support/core_ext/object'

# Add/Remove entries as needed.
configuration = {
}

missing_config = configuration.select do |name, _desc|
  if ENV[name.to_s].blank?
    true
  else
    false
  end
end

unless missing_config.empty?
  raise ArgumentError, "Missing required configuration variables: #{missing_config.keys.join(',')}"
end
