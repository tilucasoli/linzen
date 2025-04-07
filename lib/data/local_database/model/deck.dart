import 'package:linzen/domain/deck.dart';

class LocalDeck {
  final String id;
  final String name;
  final DateTime createdAt;

  LocalDeck({required this.id, required this.name, required this.createdAt});

  LocalDeck copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return LocalDeck(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

extension LocalDeckX on LocalDeck {
  static Deck toDomain(LocalDeck localDeck) => Deck(
    id: localDeck.id,
    name: localDeck.name,
    createdAt: localDeck.createdAt,
  );
}
