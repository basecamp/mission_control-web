class AddApplicationNameToRoute < ActiveRecord::Migration[7.0]
  def change
    add_column :mission_control_web_routes, :application_name, :string
  end
end
