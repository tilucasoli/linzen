import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:linzen/domain/deck.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repository/deck.dart';

class DeckViewModel extends ChangeNotifier {
  final DeckRepository _deckRepository;

  DeckViewModel({required DeckRepository deckRepository})
    : _deckRepository = deckRepository;

  List<Deck> _decks = [];
  List<Deck> get decks => _decks;

  late final createDeck = Command1<Unit, String>(
    (name) async => await _deckRepository
        .create(name) //
        .map((deck) {
          _decks.add(deck);
          notifyListeners();
          return unit;
        }),
  );

  Future<ResultDart<Unit, DeckError>> fetchDecks() async {
    return await _deckRepository
        .fetchAll() //
        .map(
          (decks) => decks.sorted((a, b) => b.createdAt.compareTo(a.createdAt)),
        )
        .map((decks) {
          _decks.clear();
          _decks = decks;
          notifyListeners();
          return unit;
        });
  }

  Future<ResultDart<Unit, DeckError>> deleteDeck(String id) async {
    return await _deckRepository
        .delete(id) //
        .map((unit) {
          _decks.removeWhere((deck) => deck.id == id);
          notifyListeners();
          return unit;
        });
  }

  Future<ResultDart<Unit, DeckError>> updateDeck(
    String id,
    String newName,
  ) async {
    if (newName.isEmpty) {
      return Failure(DeckError.emptyDeckName);
    }

    return await _deckRepository
        .update(id, newName) //
        .map((localDeck) {
          final deckIndex = _decks.indexWhere((deck) => deck.id == id);
          if (deckIndex != -1) {
            _decks[deckIndex] = _decks[deckIndex].copyWith(name: newName);
          }
          notifyListeners();
          return unit;
        });
  }
}
