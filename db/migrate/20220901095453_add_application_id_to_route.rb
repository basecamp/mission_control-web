class AddApplicationIdToRoute < ActiveRecord::Migration[7.0]
  def change
    add_reference :mission_control_web_routes, :mission_control_web_application, null: false, foreign_key: true,
      index: { name: "index_mission_control_web_routes_on_application_id" }
  end
end
