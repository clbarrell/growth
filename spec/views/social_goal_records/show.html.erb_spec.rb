require 'rails_helper'

RSpec.describe "social_goal_records/show", type: :view do
  before(:each) do
    @social_goal_record = assign(:social_goal_record, SocialGoalRecord.create!(
      :user => nil,
      :goal => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
