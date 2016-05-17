require 'test_helper'

class RatingAnswersControllerTest < ActionController::TestCase
  setup do
    @rating_answer = rating_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rating_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rating_answer" do
    assert_difference('RatingAnswer.count') do
      post :create, rating_answer: { answer: @rating_answer.answer, date: @rating_answer.date, goal_id: @rating_answer.goal_id, question_id: @rating_answer.question_id }
    end

    assert_redirected_to rating_answer_path(assigns(:rating_answer))
  end

  test "should show rating_answer" do
    get :show, id: @rating_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rating_answer
    assert_response :success
  end

  test "should update rating_answer" do
    patch :update, id: @rating_answer, rating_answer: { answer: @rating_answer.answer, date: @rating_answer.date, goal_id: @rating_answer.goal_id, question_id: @rating_answer.question_id }
    assert_redirected_to rating_answer_path(assigns(:rating_answer))
  end

  test "should destroy rating_answer" do
    assert_difference('RatingAnswer.count', -1) do
      delete :destroy, id: @rating_answer
    end

    assert_redirected_to rating_answers_path
  end
end
