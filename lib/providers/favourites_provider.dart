import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider extends ChangeNotifier {
  Set<String> _favouriteDishIds = {'d1', 'd2'};
  Set<String> _favouriteBeverageIds = {'b1'};

  Set<String> get favouriteDishIds => _favouriteDishIds;
  Set<String> get favouriteBeverageIds => _favouriteBeverageIds;

  FavouritesProvider() {
    _loadFromPrefs();
  }

  bool isDishFavourite(String dishId) => _favouriteDishIds.contains(dishId);
  bool isBeverageFavourite(String bevId) => _favouriteBeverageIds.contains(bevId);

  void toggleDishFavourite(String dishId) {
    if (_favouriteDishIds.contains(dishId)) {
      _favouriteDishIds.remove(dishId);
    } else {
      _favouriteDishIds.add(dishId);
    }
    notifyListeners();
    _saveToPrefs();
  }

  void toggleBeverageFavourite(String bevId) {
    if (_favouriteBeverageIds.contains(bevId)) {
      _favouriteBeverageIds.remove(bevId);
    } else {
      _favouriteBeverageIds.add(bevId);
    }
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dishList = prefs.getStringList('fav_dishes');
      final bevList = prefs.getStringList('fav_beverages');

      if (dishList != null) _favouriteDishIds = dishList.toSet();
      if (bevList != null) _favouriteBeverageIds = bevList.toSet();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favourites: $e');
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('fav_dishes', _favouriteDishIds.toList());
      await prefs.setStringList('fav_beverages', _favouriteBeverageIds.toList());
    } catch (e) {
      debugPrint('Error saving favourites: $e');
    }
  }
}
