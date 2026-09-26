class Ingredient {
  final String id;
  final String name;
  final String localName;
  final String description;
  final String didYouKnow;
  final String category; // e.g., 'Alkaline', 'Fermented', 'Spice', 'Seed'
  final bool isSpicy;

  const Ingredient({
    required this.id,
    required this.name,
    required this.localName,
    required this.description,
    required this.didYouKnow,
    required this.category,
    this.isSpicy = false,
  });
}
