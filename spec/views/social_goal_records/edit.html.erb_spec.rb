require 'rails_helper'

RSpec.describe "social_goal_records/edit", type: :view do
  before(:each) do
    @social_goal_record = assign(:social_goal_record, SocialGoalRecord.create!(
      :user => nil,
      :goal => nil
    ))
  end

  it "renders the edit social_goal_record form" do
    render

    assert_select "form[action=?][method=?]", social_goal_record_path(@social_goal_record), "post" do

      assert_select "input#social_goal_record_user_id[name=?]", "social_goal_record[user_id]"

      assert_select "input#social_goal_record_goal_id[name=?]", "social_goal_record[goal_id]"
    end
  end
end
