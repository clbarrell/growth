require 'rails_helper'

RSpec.describe "BooleanAnswers", type: :request do
  describe "GET /boolean_answers" do
    it "works! (now write some real specs)" do
      get boolean_answers_path
      expect(response).to have_http_status(200)
    end
  end
end
