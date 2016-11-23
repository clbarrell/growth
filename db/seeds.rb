# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# TEMPLATE QUESTIONS
questions = [
  {text: "I paid sufficient attention to this goal", qntype: "Checkin", scale: "Agreement", default_order: 4},
  {text: "I made acceptable progress on this goal", qntype: "Checkin", scale: "Agreement", default_order: 1},
  {text: "I focussed on this goal", qntype: "Checkin", scale: "Agreement", default_order: 2},
  {text: "Describe your progress", qntype: "Checkin", scale: "Comment", default_order: 6},
  {text: "Describe your progress over this period", qntype: "Review", scale: "Comment", default_order: 4},
  {text: "I prioritised this goal enough", qntype: "Checkin", scale: "Agreement", default_order: 3},
  {text: "I've made this goal enough of a priority", qntype: "Review", scale: "Agreement", default_order: 3},
  {text: "Are you closer to your next milestone?", qntype: "Checkin", scale: "True/False", default_order: 5},
  {text: "I've progressed on this goal", qntype: "Review", scale: "True/False", default_order: 1},
  {text: "I am satisfied with this progress", qntype: "Review", scale: "Agreement", default_order: 2},
  {text: "How much closer are you to your next milestone? What's required to get you there?", qntype: "Review", scale: "Comment", default_order: 5},
  {text: "How will you rectify this by next checkin?", qntype: "Review", scale: "Comment", default_order: 6}
]

questions.each do |question|
  TemplateQuestion.create(question)
end

# user
user = User.create(name: "Chris Barrell", email: "clbarrell@gmail.com", password: "kankyman")
user2 = User.create(name: "Josh Barrell", email: "josh@josh.com", password: "joshjosh")
user3 = User.create(name: "Nick Tommy", email: "nick@nick.com", password: "nicknick")

# GOAL
goal = Goal.create(description: "I want to speak clearly, concisely and with impact. I don't want to muddle my words.",
            frequency: "Daily",
            success_description: "When I've done a presentation at a conference", title: "Speak clearer!", user: user)
goal2 = Goal.create(description: "I need to work on my personal development. I'm not giving it enough attention.",
            frequency: "Daily",
            success_description: "When I've done a course & conference", title: "Personal development", user: user2)
goal3 = Goal.create(description: "I want to improve my writing",
            frequency: "Daily",
            success_description: "When I've written a blog post", title: "Writing skills", user: user3)

# CHECKIN
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus sapien nec ultricies feugiat. "
goal.checkin_questions.each do |q|
  if q.scale == "Agreement"
    # RATING ANSWERSS
    5.times { |x| RatingAnswer.create(answer: rand(2..5), created_at: x.days.ago, question: q)}
  elsif q.scale == "True/False"
    # BOOLEAN
    5.times { |x| BooleanAnswer.create(answer: [true, false].sample, created_at: x.days.ago, question: q)}
  elsif q.scale == "Comment"
    5.times { |x| CommentAnswer.create(answer: text * rand(1..3), created_at: x.days.ago, question: q)}
  end
end
5.times { |x| CheckinLog.create(checked_in_at: (x + 1).days.ago, goal: goal) }
CheckinLog.create(checked_in_at: Time.zone.today, goal: goal)

# Social goal records
SocialGoalRecord.create(user: user,
                        goal: goal2,
                        goal_owner: user2)
SocialGoalRecord.create(user: user2,
                        goal: goal,
                        goal_owner: user)
SocialGoalRecord.create(user: user3,
                    goal: goal,
                    goal_owner: user)
