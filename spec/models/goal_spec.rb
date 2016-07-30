require 'rails_helper'

RSpec.describe Goal, type: :model do
  it "makes a new goal", :focus => true do
    goal = Goal.new

    expect(goal.checkin_count).to eq(0)

  end

end
