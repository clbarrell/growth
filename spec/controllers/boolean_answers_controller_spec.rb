require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe BooleanAnswersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # BooleanAnswer. As you add validations to BooleanAnswer, be sure to
  # adjust the attributes here as well.

  let(:invalid_attributes) { {:answer => nil} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BooleanAnswersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all boolean_answers as @boolean_answers" do
      boolean_answer = build(:boolean_answer)
      get :index, {}, valid_session
      expect(assigns(:boolean_answers)).to eq([boolean_answer])
    end
  end

  describe "GET #show" do
    it "assigns the requested boolean_answer as @boolean_answer" do
      boolean_answer = build(:boolean_answer)
      get :show, {:id => boolean_answer.to_param}, valid_session
      expect(assigns(:boolean_answer)).to eq(boolean_answer)
    end
  end

  describe "GET #new" do
    it "assigns a new boolean_answer as @boolean_answer" do
      get :new, {}, valid_session
      expect(assigns(:boolean_answer)).to be_a_new(BooleanAnswer)
    end
  end

  describe "GET #edit" do
    it "assigns the requested boolean_answer as @boolean_answer" do
      boolean_answer = build(:boolean_answer)
      get :edit, {:id => boolean_answer.to_param}, valid_session
      expect(assigns(:boolean_answer)).to eq(boolean_answer)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BooleanAnswer" do
        expect {
          post :create, {:boolean_answer => attributes_for(:boolean_answer)}, valid_session
        }.to change(BooleanAnswer, :count).by(1)
      end

      it "assigns a newly created boolean_answer as @boolean_answer" do
        post :create, {:boolean_answer => attributes_for(:boolean_answer)}, valid_session
        expect(assigns(:boolean_answer)).to be_a(BooleanAnswer)
        expect(assigns(:boolean_answer)).to be_persisted
      end

      it "redirects to the created boolean_answer" do
        post :create, {:boolean_answer => attributes_for(:boolean_answer)}, valid_session
        expect(response).to redirect_to(BooleanAnswer.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved boolean_answer as @boolean_answer" do
        post :create, {:boolean_answer => invalid_attributes}, valid_session
        expect(assigns(:boolean_answer)).to be_a_new(BooleanAnswer)
      end

      it "re-renders the 'new' template" do
        post :create, {:boolean_answer => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for(:boolean_answer) }

      it "updates the requested boolean_answer" do
        boolean_answer = build_stubbed(:boolean_answer)
        put :update, {:id => boolean_answer.to_param, :boolean_answer => new_attributes}, valid_session
        boolean_answer.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested boolean_answer as @boolean_answer" do
        boolean_answer = build_stubbed(:boolean_answer)
        put :update, {:id => boolean_answer.to_param, :boolean_answer => valid_attributes}, valid_session
        expect(assigns(:boolean_answer)).to eq(boolean_answer)
      end

      it "redirects to the boolean_answer" do
        boolean_answer = build_stubbed(:boolean_answer)
        put :update, {:id => boolean_answer.to_param, :boolean_answer => valid_attributes}, valid_session
        expect(response).to redirect_to(boolean_answer)
      end
    end

    context "with invalid params" do
      it "assigns the boolean_answer as @boolean_answer" do
        boolean_answer = build_stubbed(:boolean_answer)
        put :update, {:id => boolean_answer.to_param, :boolean_answer => invalid_attributes}, valid_session
        expect(assigns(:boolean_answer)).to eq(boolean_answer)
      end

      it "re-renders the 'edit' template" do
        boolean_answer = build_stubbed(:boolean_answer)
        put :update, {:id => boolean_answer.to_param, :boolean_answer => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested boolean_answer" do
      boolean_answer = build_stubbed(:boolean_answer)
      expect {
        delete :destroy, {:id => boolean_answer.to_param}, valid_session
      }.to change(BooleanAnswer, :count).by(-1)
    end

    it "redirects to the boolean_answers list" do
      boolean_answer = build_stubbed(:boolean_answer)
      delete :destroy, {:id => boolean_answer.to_param}, valid_session
      expect(response).to redirect_to(boolean_answers_url)
    end
  end

end
