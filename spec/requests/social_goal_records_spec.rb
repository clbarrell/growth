require 'rails_helper'

RSpec.describe "SocialGoalRecords", type: :request do
  describe "GET /social_goal_records" do
    it "works! (now write some real specs)" do
      get social_goal_records_path
      expect(response).to have_http_status(200)
    end
  end
end
