class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :enabled,   :boolean, default: true
  attribute :cache_ttl, :integer, default: 10.seconds

  def disabled?
    !enabled
  end
end
