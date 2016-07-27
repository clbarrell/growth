require 'rails_helper'

RSpec.describe "template_questions/edit", type: :view do
  before(:each) do
    @template_question = assign(:template_question, TemplateQuestion.create!(
      :text => "MyString",
      :qntype => "MyString",
      :scale => "MyString",
      :default_order => 1
    ))
  end

  it "renders the edit template_question form" do
    render

    assert_select "form[action=?][method=?]", template_question_path(@template_question), "post" do

      assert_select "input#template_question_text[name=?]", "template_question[text]"

      assert_select "input#template_question_qntype[name=?]", "template_question[qntype]"

      assert_select "input#template_question_scale[name=?]", "template_question[scale]"

      assert_select "input#template_question_default_order[name=?]", "template_question[default_order]"
    end
  end
end
