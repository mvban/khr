import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../models/dish.dart';

class MenuProvider extends ChangeNotifier {
  String? _selectedRegionId;
  String? _selectedDietaryTag; // 'GF', 'DF', 'V', 'VG'
  int? _maxSpiceLevel;
  String _searchQuery = '';

  String? get selectedRegionId => _selectedRegionId;
  String? get selectedDietaryTag => _selectedDietaryTag;
  int? get maxSpiceLevel => _maxSpiceLevel;
  String get searchQuery => _searchQuery;

  List<Dish> get filteredDishes {
    return MockData.dishes.where((dish) {
      if (_selectedRegionId != null && dish.regionId != _selectedRegionId) {
        return false;
      }
      if (_selectedDietaryTag != null && !dish.dietaryTags.contains(_selectedDietaryTag)) {
        return false;
      }
      if (_maxSpiceLevel != null && dish.spiceLevel > _maxSpiceLevel!) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchName = dish.name.toLowerCase().contains(query);
        final matchRegion = dish.regionName.toLowerCase().contains(query);
        final matchDesc = dish.shortDescription.toLowerCase().contains(query);
        if (!matchName && !matchRegion && !matchDesc) return false;
      }
      return true;
    }).toList();
  }

  void setRegionFilter(String? regionId) {
    _selectedRegionId = regionId;
    notifyListeners();
  }

  void setDietaryFilter(String? tag) {
    _selectedDietaryTag = tag;
    notifyListeners();
  }

  void setMaxSpiceLevel(int? level) {
    _maxSpiceLevel = level;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilters() {
    _selectedRegionId = null;
    _selectedDietaryTag = null;
    _maxSpiceLevel = null;
    _searchQuery = '';
    notifyListeners();
  }
}
