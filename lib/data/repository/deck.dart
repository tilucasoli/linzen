import 'package:linzen/shared/result.dart';

import '../../domain/deck.dart';

enum DeckError implements Exception { duplicateDeck }

class DeckRepository {
  final List<Deck> _cachedDecks = [];

  Result<Deck, DeckError> createDeck(String name) {
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
