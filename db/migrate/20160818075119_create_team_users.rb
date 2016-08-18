class CreateTeamUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.references :team
      t.references :user
      t.integer :level

      t.timestamps
    end
  end
end
