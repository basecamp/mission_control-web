class CreateMissionControlWebApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :mission_control_web_applications do |t|
      t.string :name

      t.timestamps
    end
  end
end
