class AddAppPathToMissionControlWebRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :mission_control_web_routes, :app_path, :string
  end
end