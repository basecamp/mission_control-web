Rails.application.configure do
  # Middleware
  config.mission_control.web.host_application_name = "Dummy App"
  config.mission_control.web.redis = Redis.new(url: "redis://localhost:6379/15")
  # Admin
  config.mission_control.web.administered_applications = [
    { name: "Dummy App", redis: Redis.new(url: "redis://localhost:6379/15") },
    { name: "Another Dummy App", redis: Redis.new(url: "redis://localhost:6379/15") }
  ]
end
