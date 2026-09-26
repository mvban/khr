import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/favourites_provider.dart';
import '../widgets/dish_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavouritesProvider>();
    final favDishes = MockData.dishes
        .where((d) => favProvider.isDishFavourite(d.id))
        .toList();
    final favBeverages = MockData.beverages
        .where((b) => favProvider.isBeverageFavourite(b.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved & Taste Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Taste Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.sandBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderGrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.psychology_rounded, color: AppTheme.terracotta, size: 24),
                        SizedBox(width: 10),
                        Text(
                          'Your Private Taste Profile',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Based on your ${favDishes.length} favourited dishes:',
                      style: const TextStyle(fontSize: 12, color: AppTheme.mutedText),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTasteChip('Prefers: Gluten-Free'),
                        _buildTasteChip('Spice Comfort: Medium 🔥🔥'),
                        _buildTasteChip('Top Region: Assam & Nagaland'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Saved Dishes Header
              Text(
                'Favourited Dishes (${favDishes.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (favDishes.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('No dishes favourited yet. Tap heart icon on any dish!'),
                    ),
                  ),
                )
              else
                ...favDishes.map(
                  (dish) => DishCard(
                    dish: dish,
                    onTap: () => context.push('/dish/${dish.id}'),
                  ),
                ),

              const SizedBox(height: 24),

              // Saved Beverages Header
              Text(
                'Favourited Drinks (${favBeverages.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (favBeverages.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('No drinks favourited yet.'),
                    ),
                  ),
                )
              else
                ...favBeverages.map(
                  (bev) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(bev.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${bev.description} • \$${bev.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_rounded, color: AppTheme.terracotta),
                        onPressed: () => favProvider.toggleBeverageFavourite(bev.id),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasteChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.bananaLeafGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.bananaLeafGreen.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.bananaLeafGreen),
      ),
    );
  }
}
