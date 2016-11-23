require 'rails_helper'

RSpec.describe "social_goal_records/index", type: :view do
  before(:each) do
    assign(:social_goal_records, [
      SocialGoalRecord.create!(
        :user => nil,
        :goal => nil
      ),
      SocialGoalRecord.create!(
        :user => nil,
        :goal => nil
      )
    ])
  end

  it "renders a list of social_goal_records" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
