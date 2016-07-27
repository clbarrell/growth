require 'rails_helper'

RSpec.describe "template_questions/index", type: :view do
  before(:each) do
    assign(:template_questions, [
      TemplateQuestion.create!(
        :text => "Text",
        :qntype => "Qntype",
        :scale => "Scale",
        :default_order => 1
      ),
      TemplateQuestion.create!(
        :text => "Text",
        :qntype => "Qntype",
        :scale => "Scale",
        :default_order => 1
      )
    ])
  end

  it "renders a list of template_questions" do
    render
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "Qntype".to_s, :count => 2
    assert_select "tr>td", :text => "Scale".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
