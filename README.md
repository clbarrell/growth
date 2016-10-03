# READ ME

## To do next

- change checkin date dropdown
  - needs to change:
    - [x] `created_at` date for all answers
    - [x] checkin_log date & [x] created_at date
    - [x] don't allow for previous checkin if it was already done!!
  - OPTION
    - [x] Dropdown menu -> today / yesterday / day before yesterday
    - [x] MENU DATA -> do nothing / update all ratings & answers to `1.day.ago`/ ... change all updated_at to 2.days.ago
    - [x] create Goal function to rewrite all of today's entries
  - problems
    - it looks like the created_at time is using TIme.now which is different to Date.today, used for the checkin_logs
    - [1/2] write migration to copy from `checkin_log.date` to `checkin_log.checked_in_at` (datetime)
      [1/2] update(checked_in_at: a.date.to_datetime)
    - [1] make use of new column of `goal.last_checkin`
      [1/2] write migration for this too!
      ```Goal.find_each do |g|
[2] pry(main)*   g.update(last_checkin: g.checkin_logs.try(:last).checked_in_at)
[2] pry(main)* end```
- a way to educate new uesrs on how ot use goals?
- better title


## Coming Up

- setup mailer
  - email'd reminders
  - include calendar invites t0 force people to make space for this
  - What kinds of emails requried?
- Create a card layout for the goals
  - https://dribbble.com/shots/890839-Sneak-Peek
  - big red header where goal title goes?
  - https://dribbble.com/shots/1698678-Apps-Dashboard
- **Redesign layout - make it more appy**
  - colour
    - https://www.materialui.co/colors
    - https://www.materialpalette.com/indigo/light-blue
  - fix the sizing problems of header
    - Add your own class to the <div class="special-container"> and override the width property at one or more viewport sizes.
    - For example:  
      - @media (min-width: 768px) { ... }
    - http://www.bootply.com/109653
- adjust checkin_log graph depending on goal.frequency & amount of checkins
  - set a maximum time frame to capture



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
- Side bar
  - https://blackrockdigital.github.io/startbootstrap-simple-sidebar/
  - https://github.com/BlackrockDigital/startbootstrap-simple-sidebar/blob/master/index.html

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
