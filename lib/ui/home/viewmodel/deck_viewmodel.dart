import 'package:flutter/widgets.dart';
import 'package:linzen/domain/deck.dart';
import 'package:linzen/shared/result.dart';

import '../../../data/repository/deck.dart';

class DeckViewModel extends ChangeNotifier {
  final DeckRepository _deckRepository;

  DeckViewModel({required DeckRepository deckRepository})
    : _deckRepository = deckRepository;

  List<Deck> _decks = [];
  List<Deck> get decks => _decks;

  Future<Result<Unit, DeckError>> createDeck(String name) async {
    return (await _deckRepository.create(name)) //
    .map((deck) {
      decks.add(deck);
      notifyListeners();
      return unit;
    });
  }

  Future<Result<Unit, DeckError>> fetchDecks() async {
    final deckList = await _deckRepository.fetchAll();
    return deckList.map((decks) {
      _decks.clear();
      _decks = decks;
      notifyListeners();
      return unit;
    });
  }

  Future<Result<Unit, DeckError>> deleteDeck(String id) async {
    final result = await _deckRepository.delete(id);
    return result.map((unit) {
      _decks.removeWhere((deck) => deck.id == id);
      notifyListeners();
      return unit;
    });
  }
}
