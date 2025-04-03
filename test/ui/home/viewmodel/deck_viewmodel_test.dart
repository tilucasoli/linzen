import 'package:flutter_test/flutter_test.dart';
import 'package:linzen/shared/result.dart';
import 'package:linzen/ui/home/viewmodel/deck_viewmodel.dart';

import '../../../helpers/matcher.dart';

void main() {
  group('DeckViewModel', () {
    test('should add a deck when the method createDeck is called', () {
      final sut = DeckViewModel();

      final result = sut.createDeck('Test Deck');

      expect(result, isA<Success>());
      expect(sut.decks.length, 1);
      expect(sut.decks[0].name, 'Test Deck');
    });

    test('should not fail when tries to create a deck with the same name', () {
      final sut = DeckViewModel();

      sut.createDeck('Test Deck');
      final result = sut.createDeck('Test Deck');

      expect(sut.decks.length, 1);
      expect(result, isAFailureEnum(DeckError.duplicateDeck));
    });
  });
}
