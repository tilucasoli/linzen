## ADR 1 – Local Storage Engine Selection

**Title:** Choose local database engine for deck and card persistence

### Context
You need persistent local storage to manage decks and cards. Options include:
- `sqflite` (SQLite for Flutter)
- `hive` (NoSQL, key-value)

### Decision
Choose **Hive** for its simplicity, performance, and suitability for structured and unstructured local data.

### Consequences
- Faster reads/writes than SQLite for small datasets.
- Easier migration/versioning.
- No SQL layer needed, less boilerplate.
