import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/passport_provider.dart';

class IngredientDetailScreen extends StatelessWidget {
  final String ingredientId;

  const IngredientDetailScreen({super.key, required this.ingredientId});

  @override
  Widget build(BuildContext context) {
    final ingredient = MockData.ingredients.firstWhere(
      (i) => i.id == ingredientId,
      orElse: () => MockData.ingredients.first,
    );

    final passportProvider = context.watch<PassportProvider>();
    final isUnlocked = passportProvider.isIngredientUnlocked(ingredient.id);
    final usingDishes = MockData.dishes
        .where((d) => d.ingredientIds.contains(ingredient.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(ingredient.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ingredient Card Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.bananaLeafGreen, AppTheme.bananaLeafLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            ingredient.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                              color: isUnlocked ? AppTheme.turmericGold : Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isUnlocked ? 'Unlocked' : 'Locked',
                              style: TextStyle(
                                color: isUnlocked ? AppTheme.turmericGold : Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      ingredient.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Local Name: ${ingredient.localName}',
                      style: const TextStyle(fontSize: 14, color: Colors.white70, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Description
              Text(
                'About this Ingredient',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                ingredient.description,
                style: const TextStyle(fontSize: 15, height: 1.5, color: AppTheme.darkCharcoal),
              ),
              const SizedBox(height: 24),

              // Did You Know Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.turmericGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.turmericGold),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_rounded, color: AppTheme.darkCharcoal, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DID YOU KNOW?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkCharcoal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ingredient.didYouKnow,
                            style: const TextStyle(fontSize: 13, height: 1.4, color: AppTheme.darkCharcoal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Dishes Using This Ingredient
              Text(
                'Dishes Featuring ${ingredient.localName}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (usingDishes.isEmpty)
                const Text('No current dishes listed with this ingredient.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: usingDishes.length,
                  itemBuilder: (context, index) {
                    final dish = usingDishes[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(dish.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${dish.regionName} • \$${dish.price.toStringAsFixed(2)}'),
                        trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.terracotta),
                        onTap: () => context.push('/dish/${dish.id}'),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
