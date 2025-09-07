FLASHCARD APP -- GOOGLE DEVELOPER GROUP RECRUITMENTS

A flashcard app designed to make learning easier for complex topics like Data Structures, Algorithms, Cybersecurity, Database Systems and many more computer science topics.

This app has been implemented using Flutter sdk.
OpenAI API used to generate questions for the flashcards
(However my quota for the API has run out and thus there are no questions showing up in the flashcard,
I have been going through paths of signing another API key/ syncing questions databases)

- Starts off with a login/sign up page which then leads to the homepage.
- Homepage contains a progress tracker circle (not implemented yet as flashcards aren't working)
- Followed my the progress tracker circle is the subject boxes which in turn lead to subject wise topics pages.
- When user clicks on a particular topic, they enter directly into the flashcard page (Feature in mind : a pop up for the user to input number of flashcards to be tested and then click confirm to move into flashcards)
- Homescreen also contains and Explore page to add more subjects
- Courses page that lists 'MY Courses' as well as 'Interested Courses'
- Menu on the right with Profile, Settings and Help page
- Feature to toggle between light and dark mode

<img width="413" height="1200" alt="image" src="https://github.com/user-attachments/assets/df33b8bd-b0d8-464c-abd9-b8caa2fdd284" />
<img width="413" height="1200" alt="image" src="https://github.com/user-attachments/assets/31891f16-9297-4355-bc00-d11838c8f975" />
<img width="413" height="1200" alt="image" src="https://github.com/user-attachments/assets/15dba61f-2486-4ed1-a6f1-9e64471586de" />



TASK PROGRESS :


Level 1: Basic Flashcards
● Create a simple flashcards screen.      [DONE]
● A user should be able to add new cards (with a question and answer).    [NOT IMPLEMENTED]
● The user can view all cards and tap a card to flip it between question and
answer.   [DONE]
(Doesn’t have to be pixel-perfect just a working UI with some functionality.)
Level 2: Navigation & Progress
● Support multiple flashcards and allow navigation (Next/Prev buttons or swipe
left/right).    [DONE]
● Show the current card number (like “3 of 10”).    [DONE]
● Add support for images on flashcards (e.g., a flashcard can contain a picture
along with text).    [NOT IMPLEMENTED]
● Add a feature to mark a card as “learned”, so it no longer appears in the
review list.    [NOT IMPLEMENTED]
Level 3: Categories & Persistence
● Add categories (like Math, Science, History). The user should be able to pick
a category and only see those flashcards.      [DONE]
● Save flashcards and progress in local storage/database, so data is not lost
when the app closes.      [NOT IMPLEMENTED]
● Add dark mode and feature to toggle modes.    [DONE]
