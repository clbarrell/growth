# READ ME

## To do next

- Make checkin count 0 for days without checkins
- dont' include answers from checkins where answer = nil
- Chcek original notes for personal development journal

## Coming Up

- Feature tests to ensure whole thing operates as expected
  - https://github.com/jnicklas/capybara
  - https://github.com/eliotsykes/rspec-rails-examples#capybara-examples
- Redesign layout - make it more appy
  - Side bar
  - more background pictures - minimal vibes
  - http://demos.creative-tim.com/light-bootstrap-dashboard-pro/examples/dashboard.html
- install a login / logout method - cancancan, devise, clearance
  - https://github.com/thoughtbot/clearance
  - design the experience flow
  - ensure page flow is good. Adjust as needed.
- adjust checkin_log graph depending on goal.frequency & amount of checkins
  - Don't show until checkin_count eq 2
  - set a maximum time frame to capture
- setup mailer
  - email'd reminders
  - include calendar invites t0 force people to make space for this


## Someday features

- create the 'review' module
  - at longer time scale, show previous answers + progress, then
    ask things like:
    - Are you satisfied with this progress?
    - How much closer are you to your next milestone?
    - How will you make better progress next week?
- %goal% variable replacement in question wording
- integrate Jquery whn needed - http://jquerypp.com/
- each goal can have multiple milestones

## Completed!

- templated questions that can be copied to new goals
- checkins actually work
- get rid of actual_questions
- allow addition of questions to a goal
- migrate to PostGreSql
- install groupdate & chartkick
- clean up new question page
- create a single feature spec
- create 'View Answers' page - pseudo reporting
- create checkin_log table
- remove goal columns: checkin_count and last_checkin
- Replacing dropdown question with radios
