import 'package:flutter/widgets.dart';
import 'package:linzen/domain/deck.dart';
import 'package:linzen/shared/result.dart';

enum DeckError implements Exception { duplicateDeck }

class DeckViewModel extends ChangeNotifier {
  final List<Deck> decks = [];

  Result<Unit, DeckError> createDeck(String name) {
    if (_verifyIfDeckExists(name)) {
      return Failure(error: DeckError.duplicateDeck);
    }

    decks.add(Deck(id: '1', name: name, createdAt: DateTime.now()));
    notifyListeners();

    return Success.unit();
  }

  bool _verifyIfDeckExists(String name) {
    return decks.any((deck) => deck.name == name);
  }
}
