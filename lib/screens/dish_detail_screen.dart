import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/favourites_provider.dart';
import '../providers/passport_provider.dart';
import '../services/toast_reservation_service.dart';
import '../widgets/region_badge.dart';
import '../widgets/ingredient_chip.dart';

class DishDetailScreen extends StatelessWidget {
  final String dishId;

  const DishDetailScreen({super.key, required this.dishId});

  @override
  Widget build(BuildContext context) {
    final dish = MockData.dishes.firstWhere(
      (d) => d.id == dishId,
      orElse: () => MockData.dishes.first,
    );

    final favProvider = context.watch<FavouritesProvider>();
    final passportProvider = context.watch<PassportProvider>();
    final isFav = favProvider.isDishFavourite(dish.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
              color: isFav ? AppTheme.terracotta : Colors.white,
            ),
            onPressed: () {
              favProvider.toggleDishFavourite(dish.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Region & Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegionBadge(
                    regionName: dish.regionName,
                    onTap: () => context.push('/passport/${dish.regionId}'),
                  ),
                  Text(
                    '\$${dish.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.terracotta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                dish.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Dietary Tags & Spice
              Row(
                children: [
                  ...dish.dietaryTags.map(
                    (tag) => Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.chipBackground,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (dish.spiceLevel > 0)
                    Row(
                      children: List.generate(
                        dish.spiceLevel,
                        (_) => const Icon(Icons.local_fire_department_rounded, size: 18, color: Colors.orange),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                dish.shortDescription,
                style: const TextStyle(fontSize: 16, height: 1.4, color: AppTheme.darkCharcoal),
              ),
              const SizedBox(height: 24),

              // Dish Story Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.sandBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderGrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_stories_rounded, color: AppTheme.terracotta, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'THE DISH STORY',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.terracotta,
                                fontSize: 13,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dish.story,
                      style: const TextStyle(fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Key Ingredients Section
              Text(
                'Key Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dish.ingredientIds.map((ingId) {
                  final ing = MockData.ingredients.firstWhere(
                    (i) => i.id == ingId,
                    orElse: () => MockData.ingredients.first,
                  );
                  return IngredientChip(
                    label: ing.name,
                    isUnlocked: passportProvider.isIngredientUnlocked(ing.id),
                    onTap: () => context.push('/ingredient/${ing.id}'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Pairing Suggestion Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.bananaLeafGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.bananaLeafGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.wine_bar_rounded, color: AppTheme.bananaLeafGreen, size: 26),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'RECOMMENDED PAIRING',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.bananaLeafGreen,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dish.pairingSuggestion,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Reserve / Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Mark dish tried in regional passport
                    passportProvider.markDishTried(
                      dish.regionId,
                      dish.ingredientIds.isNotEmpty ? dish.ingredientIds.first : 'khaar_ing',
                    );
                    ToastReservationService.reserveTable(context);
                  },
                  icon: const Icon(Icons.table_restaurant_rounded),
                  label: const Text('RESERVE TABLE / ORDER THIS DISH'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
