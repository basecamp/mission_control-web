class MissionControl::Web::Application < ApplicationRecord
  has_many :routes, class_name: "MissionControl::Web::Route"

  def redis
    MissionControl::Web.configuration.administered_applications.
      detect { |application| application[:name] == name }&.dig(:redis)
  end
end
