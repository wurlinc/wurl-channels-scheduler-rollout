# service_timeout:   15     # RACK_TIMEOUT_SERVICE_TIMEOUT
# wait_timeout:      30     # RACK_TIMEOUT_WAIT_TIMEOUT
# wait_overtime:     60     # RACK_TIMEOUT_WAIT_OVERTIME
# service_past_wait: false  # RACK_TIMEOUT_SERVICE_PAST_WAIT
Rails.application.config.middleware.insert_after Rack::Runtime, Rack::Timeout
