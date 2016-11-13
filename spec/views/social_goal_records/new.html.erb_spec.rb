require 'rails_helper'

RSpec.describe "social_goal_records/new", type: :view do
  before(:each) do
    assign(:social_goal_record, SocialGoalRecord.new(
      :user => nil,
      :goal => nil
    ))
  end

  it "renders new social_goal_record form" do
    render

    assert_select "form[action=?][method=?]", social_goal_records_path, "post" do

      assert_select "input#social_goal_record_user_id[name=?]", "social_goal_record[user_id]"

      assert_select "input#social_goal_record_goal_id[name=?]", "social_goal_record[goal_id]"
    end
  end
end
