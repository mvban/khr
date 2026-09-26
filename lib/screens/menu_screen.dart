import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/menu_provider.dart';
import '../widgets/dish_card.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();
    final dishes = menuProvider.filteredDishes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Khaar Menu'),
        actions: [
          if (menuProvider.selectedRegionId != null ||
              menuProvider.selectedDietaryTag != null ||
              menuProvider.maxSpiceLevel != null ||
              menuProvider.searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all_rounded),
              tooltip: 'Clear Filters',
              onPressed: () => menuProvider.clearFilters(),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Header Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            color: AppTheme.sandBackground,
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (val) => menuProvider.setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'Search dishes, ingredients, or regions...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.terracotta),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppTheme.borderGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppTheme.borderGrey),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Dietary Tag Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        'Dietary: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      ...['GF', 'DF', 'V', 'VG'].map(
                        (tag) {
                          final isSel = menuProvider.selectedDietaryTag == tag;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: FilterChip(
                              label: Text(tag),
                              selected: isSel,
                              selectedColor: AppTheme.bananaLeafGreen,
                              labelStyle: TextStyle(
                                color: isSel ? Colors.white : AppTheme.darkCharcoal,
                                fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                              ),
                              onSelected: (selected) {
                                menuProvider.setDietaryFilter(selected ? tag : null);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Region Filter Horizontal Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        'Region: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      ChoiceChip(
                        label: const Text('All Regions'),
                        selected: menuProvider.selectedRegionId == null,
                        selectedColor: AppTheme.terracotta,
                        labelStyle: TextStyle(
                          color: menuProvider.selectedRegionId == null ? Colors.white : AppTheme.darkCharcoal,
                        ),
                        onSelected: (_) => menuProvider.setRegionFilter(null),
                      ),
                      const SizedBox(width: 6),
                      ...MockData.regions.map(
                        (reg) {
                          final isSel = menuProvider.selectedRegionId == reg.id;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: ChoiceChip(
                              label: Text('${reg.iconEmoji} ${reg.name}'),
                              selected: isSel,
                              selectedColor: AppTheme.terracotta,
                              labelStyle: TextStyle(
                                color: isSel ? Colors.white : AppTheme.darkCharcoal,
                              ),
                              onSelected: (selected) {
                                menuProvider.setRegionFilter(selected ? reg.id : null);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Dishes List
          Expanded(
            child: dishes.isEmpty
                ? const Center(
                    child: Text('No dishes match your selected filters.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final dish = dishes[index];
                      return DishCard(
                        dish: dish,
                        onTap: () => context.push('/dish/${dish.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
