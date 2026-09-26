import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassportProvider extends ChangeNotifier {
  Set<String> _visitedStateIds = {'assam'}; // Default Assam explored
  Set<String> _unlockedIngredientIds = {'khaar_ing', 'khorisa'};
  final Map<String, int> _dishesTriedPerState = {'assam': 1};

  Set<String> get visitedStateIds => _visitedStateIds;
  Set<String> get unlockedIngredientIds => _unlockedIngredientIds;
  Map<String, int> get dishesTriedPerState => _dishesTriedPerState;

  int get totalStatesExplored => _visitedStateIds.length;
  bool get hasKhaarExplorerBadge => _visitedStateIds.length >= 8;

  PassportProvider() {
    _loadFromPrefs();
  }

  bool isStateVisited(String regionId) => _visitedStateIds.contains(regionId.toLowerCase());

  bool isIngredientUnlocked(String ingredientId) => _unlockedIngredientIds.contains(ingredientId);

  bool isChefNoteUnlocked(String regionId) {
    final count = _dishesTriedPerState[regionId.toLowerCase()] ?? 0;
    return count >= 3;
  }

  void markDishTried(String regionId, String ingredientId) {
    final regId = regionId.toLowerCase();
    _visitedStateIds.add(regId);
    _unlockedIngredientIds.add(ingredientId);

    _dishesTriedPerState[regId] = (_dishesTriedPerState[regId] ?? 0) + 1;

    notifyListeners();
    _saveToPrefs();
  }

  void toggleStateVisited(String regionId) {
    final regId = regionId.toLowerCase();
    if (_visitedStateIds.contains(regId)) {
      _visitedStateIds.remove(regId);
    } else {
      _visitedStateIds.add(regId);
    }
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final states = prefs.getStringList('passport_visited_states');
      final ing = prefs.getStringList('passport_unlocked_ingredients');

      if (states != null) _visitedStateIds = states.toSet();
      if (ing != null) _unlockedIngredientIds = ing.toSet();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading passport prefs: $e');
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('passport_visited_states', _visitedStateIds.toList());
      await prefs.setStringList('passport_unlocked_ingredients', _unlockedIngredientIds.toList());
    } catch (e) {
      debugPrint('Error saving passport prefs: $e');
    }
  }
}
