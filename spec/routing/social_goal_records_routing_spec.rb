require "rails_helper"

RSpec.describe SocialGoalRecordsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/social_goal_records").to route_to("social_goal_records#index")
    end

    it "routes to #new" do
      expect(:get => "/social_goal_records/new").to route_to("social_goal_records#new")
    end

    it "routes to #show" do
      expect(:get => "/social_goal_records/1").to route_to("social_goal_records#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/social_goal_records/1/edit").to route_to("social_goal_records#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/social_goal_records").to route_to("social_goal_records#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/social_goal_records/1").to route_to("social_goal_records#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/social_goal_records/1").to route_to("social_goal_records#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/social_goal_records/1").to route_to("social_goal_records#destroy", :id => "1")
    end

  end
end
