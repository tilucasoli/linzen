## ADR 5 – Deck Deletion Strategy

**Title:** Deleting a deck should cascade delete associated cards

### Context
Users will want to delete entire decks, and cards should not be orphaned.

### Decision
Implement cascading delete behavior when removing a deck.

### Consequences
- Simplifies storage management.
- Prevents data inconsistency.
