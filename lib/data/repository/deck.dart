import 'package:linzen/data/local_database/model/deck.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/deck.dart';
import '../local_database/service/local_storage_service.dart';

typedef LocalDeckStorage = LocalStorageService<LocalDeck>;

enum DeckError implements Exception {
  duplicateDeck,
  databaseError,
  emptyDeckName,
}

class DeckRepository {
  final _uuid = Uuid();
  final LocalDeckStorage _localDeckStorageService;

  DeckRepository({required LocalDeckStorage localDeckStorageService})
    : _localDeckStorageService = localDeckStorageService;

  // FETCH
  Future<ResultDart<Deck, DeckError>> fetch(String id) async {
    // Busca o deck pelo ID no armazenamento local
    return (await _localDeckStorageService.fetch(id))
        .map((localDeck) => LocalDeckX.toDomain(localDeck))
        .mapError((error) => DeckError.databaseError);
  }

  // FETCH ALL
  Future<ResultDart<List<Deck>, DeckError>> fetchAll() async {
    return (await _localDeckStorageService.fetchAll())
        .map((localDecks) => localDecks.map(LocalDeckX.toDomain).toList())
        .mapError((error) => DeckError.databaseError);
  }

  // CREATE
  AsyncResultDart<Deck, DeckError> create(String name) async {
    if (name.isEmpty) {
      return Failure(DeckError.emptyDeckName);
    }

    final existsResult = await _verifyIfDeckExists(name);

    if (existsResult is Failure) {
      return Failure(DeckError.duplicateDeck);
    }

    final localDeck = LocalDeck(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );

    return (await _localDeckStorageService.create(localDeck.id, localDeck))
        .map((localDeck) => LocalDeckX.toDomain(localDeck))
        .mapError((error) => DeckError.databaseError);
  }

  Future<bool> _verifyIfDeckExists(String name) async {
    final result = await _localDeckStorageService.fetchAll();
    switch (result) {
      case Success():
        return result.getOrNull().any((deck) => deck.name == name);
      case Failure():
        return false;
    }
  }

  AsyncResultDart<Unit, DeckError> delete(String id) async {
    final result = await _localDeckStorageService.delete(id);
    switch (result) {
      case Success():
        return Success.unit();
      case Failure():
        return Failure(DeckError.databaseError);
    }
  }

  AsyncResultDart<LocalDeck, DeckError> update(
    String id,
    String newName,
  ) async {
    if (await _verifyIfDeckExists(newName)) {
      return Failure(DeckError.duplicateDeck);
    }

    return await _localDeckStorageService
        .fetch(id)
        .map((localDeck) => localDeck.copyWith(name: newName))
        .flatMap((localDeck) => _localDeckStorageService.update(id, localDeck))
        .mapError((error) => DeckError.databaseError);
  }
}
