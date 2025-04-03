## PRD #1: Deck & Card Management (Local) (CRUD)

### Subject
**Deck and Card Management – Local Flashcard Content System**

### Introduction
This PRD outlines the requirements for users to manage decks and cards locally. Users can create, edit, and delete decks and associated flashcards for offline learning.

### Problem Statement
Users need an intuitive way to organize learning content into decks and flashcards, allowing full control over their study material in an offline environment.

### Goals and Objectives
- Let users create, edit, and delete decks.
- Let users create, edit, and delete cards within each deck.
- Ensure that data is stored locally and persists across app sessions.

### User Stories
#### Deck Management
- As a user, I want to create a new deck with a title so I can organize my flashcards.
- As a user, I want to rename a deck.
- As a user, I want to delete a deck and all its associated cards.

#### Card Management
- As a user, I want to add cards with front/back text inside a specific deck.
- As a user, I want to edit a card’s content.
- As a user, I want to delete a card from a deck.

### Technical Requirements
#### Data Models
- **Deck**
  - `id`: UUID
  - `name`: String
  - `createdAt`: DateTime
- **Card**
  - `id`: UUID
  - `deckId`: UUID
  - `front`: String
  - `back`: String
  - `createdAt`: DateTime

#### Storage
- Local persistence using `sqflite` or `hive`.

#### UX Notes
- Modal or bottom sheets for deck/card creation and editing.
- Visual feedback on creation/deletion.
- Show card count in deck list.

### Benefits
- Offline-first learning experience.
- Full user control over content.
- Foundation for scalable review logic.

### KPIs
- Number of decks and cards created.
- Card creation retention rate (cards added after deck creation).
- Frequency of content edits.

### Development Risks
- Ensuring cascading deletes (removing cards when a deck is deleted).
- Avoiding data corruption or duplication with local writes.

### Conclusion
This module serves as the backbone for organizing learning content in the flashcard app. Once completed, it enables personalized learning experiences tailored to user needs.
