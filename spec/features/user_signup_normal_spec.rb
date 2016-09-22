require 'rails_helper'

RSpec.feature "GoalCreations", type: :feature do
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  before(:context) do
  end
  context "new user sign up email + password", js: true do
    it "should create new user and sign in" do
      visit new_user_registration_path
      page.fill_in('user_email', :with => 'test1@test1email.com')
      page.fill_in('user_password', :with => '2jklsgjf30v')
      page.fill_in('user_password_confirmation', :with => '2jklsgjf30v')
      click_on('Sign up')
      expect(page).to have_content "Your Focus Areas"
    end
  end
end
