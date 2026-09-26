class Dish {
  final String id;
  final String name;
  final double price;
  final String regionId;
  final String regionName;
  final String shortDescription;
  final String story;
  final int spiceLevel; // 0 to 4
  final List<String> dietaryTags; // 'GF', 'DF', 'V', 'VG'
  final List<String> ingredientIds;
  final List<String> ingredientNames;
  final String pairingSuggestion;
  final bool isSignature;
  final String? audioNoteUrl;

  const Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.regionId,
    required this.regionName,
    required this.shortDescription,
    required this.story,
    required this.spiceLevel,
    required this.dietaryTags,
    required this.ingredientIds,
    required this.ingredientNames,
    required this.pairingSuggestion,
    this.isSignature = false,
    this.audioNoteUrl,
  });
}
