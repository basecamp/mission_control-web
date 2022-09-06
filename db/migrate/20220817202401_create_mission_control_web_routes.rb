class CreateMissionControlWebRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :mission_control_web_routes do |t|
      t.string :name, null: false
      t.string :pattern, null: false, index: { unique: true }
      t.boolean :enabled, default: true
      t.string :application_id, null: false

      t.timestamps
    end
  end
end
