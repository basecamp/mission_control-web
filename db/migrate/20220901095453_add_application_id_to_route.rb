class AddApplicationIdToRoute < ActiveRecord::Migration[7.0]
  def change
    add_reference :mission_control_web_routes, :application, null: false, foreign_key: { to_table: :mission_control_web_applications }
  end
end
