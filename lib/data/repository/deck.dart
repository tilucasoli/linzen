import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linzen/data/local_database/model/deck.dart';
import 'package:linzen/shared/result.dart';
import 'package:uuid/uuid.dart';

import '../../domain/deck.dart';
import '../helper/cache.dart';
import '../local_database/service/local_storage_service.dart';

typedef LocalDeckStorage = LocalStorageService<LocalDeck>;

enum DeckError implements Exception { duplicateDeck, databaseError }

class DeckRepository {
  final _uuid = Uuid();
  final LocalDeckStorage _localDeckStorageService;
  final Cache<List<Deck>> _decksCache = Cache();

  DeckRepository({required LocalDeckStorage localDeckStorageService})
    : _localDeckStorageService = localDeckStorageService;

  // FETCH
  Future<Result<List<Deck>, DeckError>> fetchAll() async {
    if (_decksCache.isEmpty) {
      final result = await _localDeckStorageService.fetchAll();

      switch (result) {
        case Success(value: final localDecks):
          final decks = localDecks.map(LocalDeckX.toDomain).toList();
          _decksCache.setCache(decks);

          return Success(value: decks);

        case Failure():
          return Failure(error: DeckError.databaseError);
      }
    }

    return Success(value: _decksCache.cache!);
  }

  // CREATE
  Future<Result<Deck, DeckError>> create(String name) async {
    if (await _verifyIfDeckExists(name)) {
      return Failure(error: DeckError.duplicateDeck);
    }
    final deck = LocalDeck(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );
    _localDeckStorageService.create(deck.id, deck);

    return Success(value: LocalDeckX.toDomain(deck));
  }

  Future<bool> _verifyIfDeckExists(String name) async {
    final decks = await _localDeckStorageService.fetchAll();

    switch (decks) {
      case Success(value: final decks):
        return decks.any((deck) => deck.name == name);
      case Failure():
        return false;
    }
  }

  Future<Result<Unit, DeckError>> delete(String id) async {
    final result = await _localDeckStorageService.delete(id);
    switch (result) {
      case Success():
        _decksCache.clearCache();
        return Success.unit();
      case Failure():
        return Failure(error: DeckError.databaseError);
    }
  }
}
