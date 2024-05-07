class CreateMissionControlWebRoutes < ActiveRecord::Migration[7.0]
  def up
    create_table :mission_control_web_routes do |t|
      t.string :name, null: false
      t.string :pattern, null: false
      t.boolean :enabled, default: true
      t.string :application_id, null: false, index: true

      t.timestamps
    end

    add_index :mission_control_web_routes, [ :application_id, :pattern ], unique: true
  end
end
