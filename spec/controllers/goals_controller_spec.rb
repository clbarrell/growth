require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  context "Can render main paths" do
    it "index has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
    it "show has a 200 status code" do
      get :show
      expect(response.status).to eq(200)
    end
    it "new has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
    it "edit has a 200 status code" do
      get :edit
      expect(response.status).to eq(200)
    end
  end


end
