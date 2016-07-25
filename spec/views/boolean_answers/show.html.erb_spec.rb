require 'rails_helper'

RSpec.describe "boolean_answers/show", type: :view do
  before(:each) do
    @boolean_answer = assign(:boolean_answer, BooleanAnswer.create!(
      :answer => false,
      :goal => nil,
      :question => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
