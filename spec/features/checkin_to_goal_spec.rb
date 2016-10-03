require 'rails_helper'
require 'byebug'

RSpec.feature "CheckinToGoal", type: :feature do
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
# https://gist.github.com/zhengjia/428105
  before(:context) do
    @user = create(:user)
    @goal = create(:goal, title: "This is a goal title", user: @user)
    create(:goal, title: "This is goal two", user: @user)
  end
  context "goal#index" do
    it "should list all goals" do
      login_as(@user, :scope => :user)
      create(:goal, title: "This is a goal title", user: @user)
      create(:goal, title: "This is goal two", user: @user)
      visit(goals_path)
      expect(page).to have_content "Your Focus Areas"
      expect(page).to have_content "This is a goal title"
      expect(page).to have_content "This is goal two"
    end
    it "should take user to goal#view" do
      @user = create(:user)
      @goal = create(:goal, title: "This is a goal title", user: @user)
      login_as(@user, :scope => :user)
      create(:goal, title: "test goal title", user: @user)
      visit(goals_path)
      click_on('test goal title')
      expect(page).to have_content "You've checked in 0 times"
    end
  end
  context "goal#checkin", js: true do
    it "page should allow checkin and go to checkin_answers" do
      @user = create(:user)
      login_as(@user, :scope => :user)
      goal = create(:goal, title: "goaltitle", user: @user)
      5.times { create(:question, goal: goal) }
      visit(checkin_goal_path(goal))
      # RATING BUTTONS //label[@data-original-title='Strongly Agree']
      page.all(:xpath, "//label[@data-original-title='Strongly Agree']").each do |x|
        x.click
      end
      # page.find(:xpath, '//label[@for="goal_goaltype_standard"]').click
      # http://www.w3schools.com/xsl/xpath_syntax.asp
      click_on('Submit Checkin')
      # expect(page).to have_content @goal.description
      expect(page).to have_content "You've checked in 1 time"
      expect(page).to have_css "div.graph-block"
    end
    it "page should checkin to two days ago" do
      user = create(:user)
      login_as(user, :scope => :user)
      goalb = create(:goal, title: "goaltitle", user: user)
      5.times { create(:question, goal: goalb) }
      visit(checkin_goal_path(goalb))
      # RATING BUTTONS //label[@data-original-title='Strongly Agree']
      page.all(:xpath, "//label[@data-original-title='Strongly Agree']").each do |x|
        x.click
      end
      # Because it's new - there should be the 3 dropdown
      page.select 'two days ago', :from => 'checkin_date'
      # page.find(:xpath, '//label[@for="goal_goaltype_standard"]').click
      # http://www.w3schools.com/xsl/xpath_syntax.asp
      click_on('Submit Checkin')
      # expect(page).to have_content @goal.description
      expect(page).to have_content "You've checked in 1 time"
      expect(page).to have_css "div.graph-block"
      expect(goal.last_checkin.try(:to_date)).to eq (Time.zone.today - 2)
    end
    it "page should checkin to yesterday" do
      user = create(:user)
      login_as(user, :scope => :user)
      goal = create(:goal, title: "goaltitle", user: user)
      5.times { create(:question, goal: goal) }
      visit(checkin_goal_path(goal))
      # RATING BUTTONS //label[@data-original-title='Strongly Agree']
      page.all(:xpath, "//label[@data-original-title='Strongly Agree']").each do |x|
        x.click
      end
      # Because it's new - there should be the 3 dropdown
      page.select 'yesterday', :from => 'checkin_date'
      # page.find(:xpath, '//label[@for="goal_goaltype_standard"]').click
      # http://www.w3schools.com/xsl/xpath_syntax.asp
      click_on('Submit Checkin')
      # expect(page).to have_content @goal.description
      expect(page).to have_content "You've checked in 1 time"
      expect(page).to have_css "div.graph-block"
      expect(goal.last_checkin.try(:to_date)).to eq (Time.zone.today - 1)
    end
  end

end
