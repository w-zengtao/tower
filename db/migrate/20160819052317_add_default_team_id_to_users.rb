class AddDefaultTeamIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :default_team_id, :integer, default: 0
  end
end
