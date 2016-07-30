require 'rails_helper'

RSpec.describe Goal, type: :model do
  before(:context) do
     # run one time only, before all of the examples in a group
     @goal = Goal.new(title: "title",
                      frequency: "Daily",
                      goaltype: "Standard",
                      description: "descirp kdl gl")
    User.create(name: "Hello first", email: "email@example.com")
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
      goal1 = @goal
      goal1.title = ""
      expect(goal1).not_to be_valid
      goal2 = @goal
      goal2.frequency = "something"
      expect(goal1).not_to be_valid
      goal3 = @goal
      goal3.goaltype = "a new goaltypw"
      expect(goal1).not_to be_valid
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
      @goal.new_checkin
      expect(@goal.checkin_count).to eq 1
    end
    it "undo should decrease checkin count" do
      @goal.undo_checkin
      expect(@goal.checkin_count).to eq 0
      expect(@goal.last_checkin).to be < 1.week.ago
    end
  end
  context "#is_it_checkin_time?" do
    it "should return true" do
      expect(@goal.is_it_checkin_time?).to be true
      @goal.last_checkin = 2.days.ago
      expect(@goal.is_it_checkin_time?).to be true
      @goal.last_checkin = 20.minutes.ago
      expect(@goal.is_it_checkin_time?).to be false
    end
  end


end
