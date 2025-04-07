class Deck {
  final String id;
  final String name;
  final DateTime createdAt;

  Deck({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  Deck copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return Deck(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}