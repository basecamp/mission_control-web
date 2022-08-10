class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :enabled, :boolean, default: true

  def disabled?
    !enabled
  end
end
