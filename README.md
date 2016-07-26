# READ ME

## To do next

- get rid of actual_questions
- each goal has_many questions
  - questions can increase / decrease
- a way to 'seed' a goal's question list with checkin and review questions
  1. have it recorded somewhere
  2. implement the seeding on goal creation
- allow addition of questions to a goal


## Coming Up

- Replacing dropdown question with radios
  - http://stackoverflow.com/questions/15060268/how-to-use-radio-button-correctly-in-rails
  - http://bootsnipp.com/snippets/featured/checkboxradio-css-only
- separate **review** questions & **checkin** questions? (I think I'll leave it be ftm)
  - hmm... Would probably be worth thinking about.  
**+++**
  - wouldn't need *scopes* as much...
  - could only have a small routing logic bit because I could Use
    separate *ReviewQuestionController* and *CheckinQuestionController* 's
**---**
  - What about *DRY* code? Do not repeat yourself.
    - How much code would be repeated between the two controllers?


## Someday features

- %goal% variable replacement in question wording
