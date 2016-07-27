require 'rails_helper'

RSpec.describe "template_questions/new", type: :view do
  before(:each) do
    assign(:template_question, TemplateQuestion.new(
      :text => "MyString",
      :qntype => "MyString",
      :scale => "MyString",
      :default_order => 1
    ))
  end

  it "renders new template_question form" do
    render

    assert_select "form[action=?][method=?]", template_questions_path, "post" do

      assert_select "input#template_question_text[name=?]", "template_question[text]"

      assert_select "input#template_question_qntype[name=?]", "template_question[qntype]"

      assert_select "input#template_question_scale[name=?]", "template_question[scale]"

      assert_select "input#template_question_default_order[name=?]", "template_question[default_order]"
    end
  end
end
