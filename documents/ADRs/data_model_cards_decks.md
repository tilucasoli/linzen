## ADR 2 – Data Model Structure for Cards and Decks

**Title:** Define data models for Deck and Card with support for review metadata

### Context
Decks and Cards need to store user-created content and review data. Cards must track repetition metadata for SM-2.

### Decision
Define models:
```dart

// deck.dart
class Deck {
  final String id;
  final String name;
  final DateTime createdAt;
}

// card.dart
class Card {
  final String id;
  final String deckId;
  final String front;
  final String back;
  final DateTime createdAt;
  final ReviewData reviewData;
}

class ReviewData {
  final DateTime lastReviewedAt;
  final DateTime dueDate;
  final int interval;
  final int repetitions;
  final double efactor;
}
```

### Consequences
- Card model is future-proofed for review algorithm.
- Enables efficient filtering of due cards per session.
