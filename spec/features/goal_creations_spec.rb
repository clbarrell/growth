require 'rails_helper'

RSpec.feature "GoalCreations", type: :feature do
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  before(:context) do

    # create(:goal, title: "This is a goal title", user: @user_with_goal)
    # create(:goal, title: "This is goal two", user: @user_with_goal)
  end
  context "goal#index" do
    it "should list no goals" do
      user = create(:user)
      login_as(user, :scope => :user)

      visit(goals_path)
      expect(page).to have_content "Your Focus Areas"
      expect(page).to have_content "You have not made any goals yet."
    end
    it "should take user to new goal page" do
      user = create(:user)
      login_as(user, :scope => :user)
      visit(goals_path)
      click_on('New Focus Area')
      expect(page).to have_content "New Focus Area"
      expect(page).to have_button "Create Goal"
    end
  end
  context "goal#new", js: true do
    it "page should create goal" do
      user = create(:user)
      login_as(user, :scope => :user)
      visit(new_goal_path)
      page.fill_in('goal_title', :with => 'This is my new goal')
      page.fill_in('goal_description', :with => 'This is the description of my new goal')
      page.find(:xpath, '//label[@for="goal_frequency_daily"]').click
      page.find(:xpath, '//label[@for="goal_goaltype_standard"]').click
      # http://www.w3schools.com/xsl/xpath_syntax.asp
      click_on('Create Goal')
      expect(page).to have_content "This is the description of my new goal"
      expect(page).to have_content "Goal was successfully created"
      expect(page).to have_content "You've checked in 0 times"
    end
  end


end
