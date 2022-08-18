class CreateMissionControlWebRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :mission_control_web_routes do |t|
      t.string :name, null: false
      t.string :pattern, null: false
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
