## ADR 3 – Review Algorithm

**Title:** Use SM-2 (Anki) spaced repetition algorithm for flashcard sessions

### Context
You need a way to schedule flashcard reviews based on user performance to maximize retention.

### Decision
Implement the SM-2 algorithm in Dart, updating card metadata after each review.

### Consequences
- Proven algorithm, improves retention.
- Can be replaced with SM-5 or other algorithms later.
- Requires careful handling of card metadata.
