require 'rails_helper'

RSpec.describe "template_questions/show", type: :view do
  before(:each) do
    @template_question = assign(:template_question, TemplateQuestion.create!(
      :text => "Text",
      :qntype => "Qntype",
      :scale => "Scale",
      :default_order => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Qntype/)
    expect(rendered).to match(/Scale/)
    expect(rendered).to match(/1/)
  end
end
