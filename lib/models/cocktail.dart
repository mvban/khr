enum BeverageType { cocktail, mocktail, wine, draftBeer }

class Beverage {
  final String id;
  final String name;
  final double price;
  final BeverageType type;
  final String description;
  final String foodPairing;
  final List<String> tags;

  const Beverage({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.description,
    required this.foodPairing,
    required this.tags,
  });
}
