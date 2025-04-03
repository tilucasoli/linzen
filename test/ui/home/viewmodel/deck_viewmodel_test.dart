import 'package:flutter_test/flutter_test.dart';
import 'package:linzen/data/repository/deck.dart';
import 'package:linzen/domain/deck.dart';
import 'package:linzen/shared/result.dart';
import 'package:linzen/ui/home/viewmodel/deck_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

class MockDeckRepository extends Mock implements DeckRepository {}

void main() {
  group('DeckViewModel', () {
    test('should add a deck when the method createDeck is called', () {
      final sut = makeSut();

      when(() => sut.mockDeckRepository.createDeck('Test Deck')).thenAnswer(
        (_) => Success(
          value: Deck(id: '1', name: 'Test Deck', createdAt: DateTime.now()),
        ),
      );

      final result = sut.viewModel.createDeck('Test Deck');

      expect(result, isA<Success>());
      expect(sut.viewModel.decks.length, 1);
      expect(sut.viewModel.decks[0].name, 'Test Deck');
    });
  });
}

({DeckViewModel viewModel, MockDeckRepository mockDeckRepository}) makeSut() {
  final mockDeckRepository = MockDeckRepository();
  return (
    viewModel: DeckViewModel(deckRepository: mockDeckRepository),
    mockDeckRepository: mockDeckRepository,
  );
}
