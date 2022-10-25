class ScopeRoutePatternUniqueness < ActiveRecord::Migration[7.0]
  def up
    remove_index :mission_control_web_routes, :pattern, unique: true

    add_index :mission_control_web_routes, [ :application_id, :pattern ], unique: true
  end
end
