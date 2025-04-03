import 'package:flutter_test/flutter_test.dart';
import 'package:linzen/data/repository/deck.dart';
import 'package:linzen/shared/result.dart';

void main() {
  group('DeckRepository', () {
    late DeckRepository sut;

    setUp(() {
      sut = DeckRepository(deckDatabase: DeckDatabase());
    });

    test('should create a deck successfully when name is unique', () {
      final result = sut.create('Test Deck');

      expect(result, isA<Success>());
      expect((result as Success).value.name, 'Test Deck');
    });

    test('should fail when trying to create a deck with duplicate name', () {
      sut.create('Test Deck');
      final result = sut.create('Test Deck');

      expect(result, isA<Failure>());
      expect((result as Failure).error, DeckError.duplicateDeck);
    });
  });
}
