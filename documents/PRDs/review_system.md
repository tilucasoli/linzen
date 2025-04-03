## PRD #2: Flashcard Review System

### Subject
**Flashcard Review Sessions – Local Learning Experience**

### Introduction
This PRD outlines the experience and logic for the flashcard review sessions. Users will go through cards in a deck, flip to see the answer, and self-assess their knowledge.

### Problem Statement
Users want to review content efficiently. They need a smooth interface that mimics flashcard practice, providing self-assessment and progress tracking — all offline.

### Goals and Objectives
- Let users start a review session from the home screen or specific deck.
- Present cards one at a time.
- Allow flipping the card to reveal the back.
- Let users self-assess their recall with four options: Again, Hard, Good, Easy.
- Use the SM-2 algorithm (as in Anki) to determine the next review interval.
- Track number of cards reviewed.

### User Stories
- As a user, I want to start a review session for any deck or all decks.
- As a user, I want to flip the flashcard to reveal the answer.
- As a user, I want to rate how well I remembered the card.
- As a user, I want to see how many cards are left in my session.

### Technical Requirements
#### Review Flow
- Retrieve cards due for review from the deck.
- Display cards front → back.
- Capture ease rating: Again, Hard, Good, Easy.
- Use the SM-2 algorithm to calculate the next due date and update the card's metadata.
- Progress bar to indicate how many cards are left.

#### Updated Data Model
- **Card** (extended)
  - `lastReviewedAt`: DateTime
  - `ease`: Enum [Again, Hard, Good, Easy]
  - `interval`: int (in days)
  - `repetitions`: int
  - `efactor`: double
  - `dueDate`: DateTime

#### SM-2 Algorithm Notes
- Initialize each card with: `interval = 1`, `repetitions = 0`, `efactor = 2.5`
- Update values based on ease rating according to SM-2 rules.

#### UX Notes
- Horizontal swipe or tap-to-flip interaction.
- Four color-coded buttons for scoring.
- Visual feedback and transitions between cards.

### Benefits
- Reinforces memory through active recall and spaced repetition.
- Mimics proven Anki algorithm for optimized long-term retention.
- Simple UI lowers the friction for quick practice.

### KPIs
- Daily sessions started.
- Cards reviewed per session.
- Most common ease score (to gauge difficulty).
- Long-term retention score (based on ease + time).

### Development Risks
- Correct and efficient implementation of SM-2 logic.
- Balancing simplicity of review with long-term accuracy of scheduling.
- Managing session state and saving reviews locally.

### Conclusion
The review system turns static content into an interactive and intelligent learning experience. By adopting the SM-2 spaced repetition algorithm from Anki, the app supports long-term memory retention in an efficient and scientifically grounded way.

