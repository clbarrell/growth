require 'rails_helper'
# setup
# EXERCISE
# VERIFY
RSpec.describe Goal, type: :model do
  before(:context) do
     # run one time only, before all of the examples in a group
    @goal = build(:goal)
    @user = @goal.user
  end

  describe "creating a basic goal" do
    it "makes a new goal with default properties" do
      expect(@goal.checkin_count).to eq(0)
      # question assignment
      expect(@goal.questions.count).to eq(0)
    end

    it "should save OK" do
      @goal.save
    end

    it "assign default questions on creation" do
      expect(@goal.questions.count).to eq(TemplateQuestion.count)
    end

    it "shouldn't allow wrong errors" do
      expect(build_stubbed(:goal, title: nil)).not_to be_valid
      expect(build_stubbed(:goal, frequency: nil)).not_to be_valid
      expect(build_stubbed(:goal, goaltype: "yesito")).not_to be_valid
    end
  end
  describe "testing the main methods" do
    it "should only return checkin questions" do
      expect(@goal.checkin_questions).to eq(Question.where(goal: @goal, qntype: "Checkin"))
    end
    it "should only return review questions" do
      expect(@goal.review_questions).to eq(Question.where(goal: @goal, qntype: "Review"))
    end
  end
  context "checking in" do
    it "should increase checkin count" do
      goal = build(:goal, :just_checked_in)
      expect(goal.checkin_count).to_not eq 0
    end
    it "undo should decrease checkin count" do
      goal = build(:goal, checkin_count: 1)
      goal.undo_checkin
      expect(goal.checkin_count).to eq 0
      expect(goal.last_checkin).to be < 1.week.ago
    end
  end
  context "#is_it_checkin_time?" do
    it "should return true" do
      goal = build(:goal, frequency: "Daily")
      expect(goal.is_it_checkin_time?).to be true
      checkedin_goal = build(:goal, :just_checked_in)
      expect(checkedin_goal.is_it_checkin_time?).to be false
      goal.new_checkin
      expect(goal.is_it_checkin_time?).to be false
    end
  end


end
