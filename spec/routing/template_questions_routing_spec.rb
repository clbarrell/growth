require "rails_helper"

RSpec.describe TemplateQuestionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/template_questions").to route_to("template_questions#index")
    end

    it "routes to #new" do
      expect(:get => "/template_questions/new").to route_to("template_questions#new")
    end

    it "routes to #show" do
      expect(:get => "/template_questions/1").to route_to("template_questions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/template_questions/1/edit").to route_to("template_questions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/template_questions").to route_to("template_questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/template_questions/1").to route_to("template_questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/template_questions/1").to route_to("template_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/template_questions/1").to route_to("template_questions#destroy", :id => "1")
    end

  end
end
