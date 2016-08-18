require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  before {
    User.destroy_all
    Team.destroy_all
    TeamUser.destroy_all
    @user = FactoryGirl.create(:user, name: 'test', email: 'test@tower.com')
  }

  it "创建一个新的团队的时候, 创建者应该是团队的超级管理员" do
    @team = @user.teams.create(name: 'test_team')

    expect(TeamUser.count).to be 1
    expect(TeamUser.first.team.name).to eq 'test_team'
    expect(TeamUser.first.user.name).to eq 'test'
    expect(TeamUser.first.level).to eq 0
  end


end
