import 'package:flutter/widgets.dart';
import 'package:linzen/domain/deck.dart';
import 'package:linzen/shared/result.dart';

import '../../../data/repository/deck.dart';

class DeckViewModel extends ChangeNotifier {
  final DeckRepository _deckRepository;

  DeckViewModel({required DeckRepository deckRepository})
    : _deckRepository = deckRepository;

  final List<Deck> decks = [];

  Result<Unit, DeckError> createDeck(String name) {
    return _deckRepository
        .createDeck(name) //
        .map((deck) {
          decks.add(deck);
          notifyListeners();
          return unit;
        });
  }
}
