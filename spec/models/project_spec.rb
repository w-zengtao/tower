require 'rails_helper'

RSpec.describe Project, type: :model do
  before {
    User.destroy_all
    Team.destroy_all
    TeamUser.destroy_all
    Todo.destroy_all
    Project.destroy_all
    Event.destroy_all

    @user = FactoryGirl.create(:user, name: 'test', email: 'test@tower.com')
    User.current = @user
  }

  it "创建一个Project的时候 必须关联上Team" do
    begin
      @project = FactoryGirl.create(:project, name: 'test_project')
    rescue Exception => e
      nil
    end
    expect(Project.count).to eq 0
  end

  it "关联Team的情况下能成功创建Project 同时测试一些函数" do
    @team = @user.teams.create(name: 'test_team')

    expect(@user.role(@team)).to eq 0 # 超级管理员

    @project = FactoryGirl.create(:project, name: 'test_project', team: @team)

    expect(Project.count).to eq 1
    expect(@user.can_admin?(@project)).to be true # 这里测试是can_admin?
    expect(@user.can_access?(@project)).to be true # 这里测试是can_access?

    @o_user = FactoryGirl.create(:user, name: 'o_test', email: 'o_test@tower.com')
    User.current = @o_user

    @o_team = @o_user.teams.create(name: 'o_test_team')
    @o_project = @o_team.projects.create(name: 'o_test_project')

    expect(@o_user.can_admin?(@project)).to be false # 这里测试是can_admin?
    expect(@o_user.can_access?(@project)).to be false # 这里测试是can_access?

    expect(@user.can_admin?(@o_project)).to be false # 这里测试是can_admin?
    expect(@user.can_access?(@o_project)).to be false # 这里测试是can_access?

    @team.team_users.create(user: @o_user, level: 1)
    expect(@o_user.role(@team)).to eq 1 # 管理员

    @project.add_member(@o_user)
    expect(@o_user.can_access?(@project)).to be false
    @o_user.team = @team
    @o_user.save
    expect(@o_user.can_access?(@project)).to be true
  end

end
