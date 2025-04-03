import 'package:linzen/shared/result.dart';

import '../../domain/deck.dart';

enum DeckError implements Exception { duplicateDeck }

class DeckRepository {
  final DeckDatabase _deckDatabase;

  DeckRepository({required DeckDatabase deckDatabase})
    : _deckDatabase = deckDatabase;

  final List<Deck> _cachedDecks = [];

  Result<List<Deck>, DeckError> fetchAll() {
    return Success(value: _cachedDecks);
  }

  Result<Deck, DeckError> create(String name) {
    if (_verifyIfDeckExists(name)) {
      return Failure(error: DeckError.duplicateDeck);
    }

    final deck = Deck(id: '1', name: name, createdAt: DateTime.now());
    _cachedDecks.add(deck);

    return Success(value: deck);
  }

  bool _verifyIfDeckExists(String name) {
    return _cachedDecks.any((deck) => deck.name == name);
  }
}

class DeckDatabase {
  Future<List<Deck>> fetchAll() async {
    return [];
  }

  Future<Deck> create(String name) async {
    return Deck(id: '1', name: name, createdAt: DateTime.now());
  }
}
