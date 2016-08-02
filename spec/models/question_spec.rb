require 'rails_helper'

RSpec.describe Question, type: :model do

  describe "testing default attributes and errors" do
    it "incorrect scale shouldn't be valid" do
      expect(build_stubbed(:question, scale: "asf")).not_to be_valid
      expect(build_stubbed(:question, scale: nil)).not_to be_valid
    end
    it "incorrect qntype shouldn't be valid" do
      expect(build_stubbed(:question, qntype: "asf")).not_to be_valid
      expect(build_stubbed(:question, qntype: nil)).not_to be_valid
    end
  end
  # describe "#set_default_order" do
  #   it "should set qnorder correctly" do
  #     goal = build(:goal)
  #     goal.create_default_questions
  #     max_qn_order = goal.questions.maximum(:qnorder) + 1
  #     question = build(:question, qnorder: nil, goal: goal)
  #     expect(question.qnorder).to eq max_qn_order
  #   end
  # end

end
