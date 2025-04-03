// import 'package:flutter_test/flutter_test.dart';
// import 'package:linzen/data/local_database/model/deck.dart';
// import 'package:linzen/data/local_database/service/local_storage_service.dart';
// import 'package:linzen/data/repository/deck.dart';
// import 'package:linzen/domain/deck.dart';
// import 'package:linzen/shared/result.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLocalDeckStorageService extends Mock
//     implements LocalStorageService<LocalDeck> {}

// // void main() {
// //   group('DeckRepository', () {
// //     late DeckRepository sut;
// //     late MockLocalDeckStorageService mockLocalDeckStorageService;

// //     setUp(() async {
// //       mockLocalDeckStorageService = MockLocalDeckStorageService();
// //       sut = DeckRepository(
// //         localDeckStorageService: mockLocalDeckStorageService,
// //       );
// //     });

// //     test('should create a deck successfully when name is unique', () {
// //       final result = sut.create('Test Deck');

// //       when(() => mockLocalDeckStorageService.create(any())).thenAnswer(
// //         (_) async => Success(value: LocalDeck(
// //           id: '1',
// //           name: 'Test Deck',
// //           createdAt: DateTime.now(),
// //         )),
// //       );

// //       expect(result, isA<Success>());
// //       expect((result as Success).value.name, 'Test Deck');
// //     });

// //     test('should fail when trying to create a deck with duplicate name', () {
// //       sut.create('Test Deck');
// //       final result = sut.create('Test Deck');

// //       expect(result, isA<Failure>());
// //       expect((result as Failure).error, DeckError.duplicateDeck);
// //     });
// //   });
// // }
