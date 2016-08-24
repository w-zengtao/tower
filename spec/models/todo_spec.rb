require 'rails_helper'

RSpec.describe Todo, type: :model do
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

  it "创建一个Todo的时候 必须关联上 Project 创建Todo的时候应该创建一个Event 由于是异步队列处理 这里先不测试" do
    @team = @user.teams.create(name: 'test_team')
    @project = FactoryGirl.create(:project, name: 'test_project', team: @team)

    begin
      @todo = FactoryGirl.create(:todo, name: 'test_todo')
    rescue Exception => e
      nil
    end

    expect(Todo.count).to eq 0

    @todo = @project.todos.create(name: 'test_todo')
    expect(Todo.count).to eq 1

  end
end
