require 'rails_helper'

RSpec.describe "boolean_answers/new", type: :view do
  before(:each) do
    assign(:boolean_answer, BooleanAnswer.new(
      :answer => false,
      :goal => nil,
      :question => nil
    ))
  end

  it "renders new boolean_answer form" do
    render

    assert_select "form[action=?][method=?]", boolean_answers_path, "post" do

      assert_select "input#boolean_answer_answer[name=?]", "boolean_answer[answer]"

      assert_select "input#boolean_answer_goal_id[name=?]", "boolean_answer[goal_id]"

      assert_select "input#boolean_answer_question_id[name=?]", "boolean_answer[question_id]"
    end
  end
end
