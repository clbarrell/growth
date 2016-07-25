require 'rails_helper'

RSpec.describe "boolean_answers/edit", type: :view do
  before(:each) do
    @boolean_answer = assign(:boolean_answer, BooleanAnswer.create!(
      :answer => false,
      :goal => nil,
      :question => nil
    ))
  end

  it "renders the edit boolean_answer form" do
    render

    assert_select "form[action=?][method=?]", boolean_answer_path(@boolean_answer), "post" do

      assert_select "input#boolean_answer_answer[name=?]", "boolean_answer[answer]"

      assert_select "input#boolean_answer_goal_id[name=?]", "boolean_answer[goal_id]"

      assert_select "input#boolean_answer_question_id[name=?]", "boolean_answer[question_id]"
    end
  end
end
