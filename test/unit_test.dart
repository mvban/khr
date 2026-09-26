import 'package:flutter_test/flutter_test.dart';
import 'package:khaar_app/data/mock_data.dart';
import 'package:khaar_app/providers/menu_provider.dart';

void main() {
  group('MockData Tests', () {
    test('Verify 8 Northeast states present', () {
      expect(MockData.regions.length, equals(8));
      final stateNames = MockData.regions.map((r) => r.state).toList();
      expect(stateNames, contains('Assam'));
      expect(stateNames, contains('Nagaland'));
      expect(stateNames, contains('Meghalaya'));
      expect(stateNames, contains('Manipur'));
      expect(stateNames, contains('Mizoram'));
      expect(stateNames, contains('Arunachal Pradesh'));
      expect(stateNames, contains('Tripura'));
      expect(stateNames, contains('Sikkim'));
    });

    test('Verify signature dishes contain required ingredients', () {
      final khaarCroquette = MockData.dishes.firstWhere((d) => d.id == 'd1');
      expect(khaarCroquette.name, equals('Khaar Croquette'));
      expect(khaarCroquette.dietaryTags, contains('GF'));
      expect(khaarCroquette.dietaryTags, contains('DF'));
    });
  });

  group('MenuProvider Filter Tests', () {
    test('Filter dishes by region', () {
      final provider = MenuProvider();
      provider.setRegionFilter('nagaland');
      expect(provider.filteredDishes.every((d) => d.regionId == 'nagaland'), isTrue);
    });

    test('Filter dishes by dietary tag', () {
      final provider = MenuProvider();
      provider.setDietaryFilter('GF');
      expect(provider.filteredDishes.every((d) => d.dietaryTags.contains('GF')), isTrue);
    });

    test('Filter dishes by search query', () {
      final provider = MenuProvider();
      provider.setSearchQuery('croquette');
      expect(provider.filteredDishes.length, equals(1));
      expect(provider.filteredDishes.first.name, equals('Khaar Croquette'));
    });
  });
}
