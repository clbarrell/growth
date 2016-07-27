require 'rails_helper'

RSpec.describe "TemplateQuestions", type: :request do
  describe "GET /template_questions" do
    it "works! (now write some real specs)" do
      get template_questions_path
      expect(response).to have_http_status(200)
    end
  end
end
