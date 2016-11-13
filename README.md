# READ ME

## To do next

- Social Goals
  - data models (`user.social_goals...`)
    - social_goals join table??
  - handle registration / adding people things - sending "please set a password" emails
  - Social Goals page
  - social goals > give access
  - Goals#index page changes
- setup mailer (heroku addons:open mailgun)
  - reminder_email_to_checkin
  - youre_on_a_roll_email
- jobs
  - create a job that searches through goals and sends reminders to checkin
- screenshots
- adjust checkin_log graph depending on goal.frequency & amount of checkins


## Coming Up

- **Redesign layout - make it more appy**
  - colour
    - https://www.materialui.co/colors
    - https://www.materialpalette.com/indigo/light-blue

## Someday features

- create the 'review' module
  - at longer time scale, show previous answers + progress, then
    ask things like:
    - Are you satisfied with this progress?
    - How much closer are you to your next milestone?
    - How will you make better progress next week?
- each goal can have multiple milestones

# Instructions

Using mailcatcher for development email finding. Run `mailcatcher` in dev to see emails, then go to `http://localhost:1080/`.

Preview emails with: `http://localhost:3000/rails/mailers`

- heroku addons:open scheduler
- rake task!!! `rake -T -A` gets a list

## Completed!

- Template questions (sep) that can be copied to new goals
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
- Check original notes for personal development journal
- dont' include answers from checkins where answer = nil
- move Goal's questions to it's own page
- Make checkin count 0 for days without checkins
- created users page
- install a login / logout method - cancancan, devise, clearance
- change the 'checkins 1' to just a label that gets added to Goals
- GOOOGLE SSO oauth
- small button shows only on xs screen for "Checkin"
- comment answers background readable
- Feature tests to ensure checkin operates as expected
- Move edit goal side menu into own buttons at bottom of goal#view page
- maybe have a button / alert that shows up when needing checkin in goal#view
- installed Puma webserver
- set up mailer
- set up delayed jobs
- set up scheduler to run those jobs
- set up a basic welcome email
