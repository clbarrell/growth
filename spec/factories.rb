FactoryGirl.define do
  # More info here:
  # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  factory :user do
    name "Chris Barrell"
    sequence(:email) { |n| "person#{n}@example.com" }
  end

  factory :rating_answer do
    answer 5
    question
  end

  factory :comment_answer do
    answer "Yes, I made amazing progress"
    question
  end

  factory :boolean_answer do
    answer true
    question
    trait :false do
      answer false
    end
  end

  factory :template_question do
    text "Have you made progress today?"
    qntype "Checkin"
    scale "Agreement"
    sequence(:default_order) { |x| x }
  end

  factory :question do
    # set default attributes
    question "Have you made progress today?"
    qntype "Checkin"
    scale "Agreement"
    sequence(:qnorder) { |x| x }
    goal #belongs_to relationship

    trait :checkin do
      qntype "Checkin"
    end

    trait :review do
      qntype "Review"
    end

    trait :first_question do
      qnorder 1
    end

    # WITH Answers
    factory :question_with_answers do
      # answer count
      transient do
        answer_count 5
        answer_type :comment_answer
      end

      after(:create) do |question, evaluator|
        create_list(evaluator.answer_type, evaluator.answer_count,
                    question: question)
      end
    end
  end

  factory :goal do
    # set default attributes
    title "I am a goal"
    description "I am a description"
    frequency "Daily"
    goaltype "Standard"
    user
    trait :with_success_desc do
      success_description "TO be successful I will..."
    end
    trait :just_checked_in do
      last_checkin { Time.now }
      checkin_count 1
    end
    trait :old_checkin do
      last_checkin { 6.weeks.ago }
      checkin_count 1
    end
    # user_with_posts will create post data after the user has been created
    factory :goal_with_questions do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        qntype "Checkin"
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |goal, evaluator|
        goal.create_default_questions
      end
      # This allows this::::: goal_with_questions
      # create(:profile).languages.length # 0
      # create(:profile_with_languages).languages.length # 5
      # create(:profile_with_languages, languages_count: 15).languages.length # 15
    end
  end
end
