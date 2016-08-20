require 'rails_helper'

RSpec.feature "GoalCreations", type: :feature do
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  before(:context) do
    @user = create(:user)
    @user_with_goal = create(:user)
    create(:goal, title: "This is a goal title", user: @user_with_goal)
    create(:goal, title: "This is goal two", user: @user_with_goal)
  end
  context "user#show" do
    it "should list no goals" do
      visit(goals_path)
      expect(page).to have_content "Your Goals"
      expect(page).to have_content "You have not made any goals yet."
    end
    it "should take user to new goal page" do
      visit(user_path(@user))
      click_on('New Goal')
      expect(page).to have_content "New Goal"
      expect(page).to have_button "Create Goal"
    end
  end
  context "goal#new", js: true do
    it "page should create goal" do
      visit(new_goal_path)
      page.fill_in('goal_title', :with => 'This is my new goal')
      page.fill_in('goal_description', :with => 'This is the description of my new goal')
      page.select('Daily', :from => 'Frequency')
      page.select('Standard', :from => 'Goaltype')
      click_on('Create Goal')
      expect(page).to have_content "This is my new goal"
      expect(page).to have_content "This is the description of my new goal"
      expect(page).to have_content "Goal was successfully created"
      expect(page).to have_content "You've checked into this goal 0 times"
    end
    it "should list all the goals" do
      visit user_path(@user_with_goal)
      expect(page).to have_content "This is a goal title"
      expect(page).to have_content "This is goal two"
      expect(page).to have_content "New Goal"
    end
  end


end
