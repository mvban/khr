import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/passport_provider.dart';
import '../widgets/dish_card.dart';

class PassportScreen extends StatelessWidget {
  final String? initialRegionId;

  const PassportScreen({super.key, this.initialRegionId});

  @override
  Widget build(BuildContext context) {
    final passport = context.watch<PassportProvider>();
    final selectedRegionId = initialRegionId ?? 'assam';
    final region = MockData.regions.firstWhere(
      (r) => r.id == selectedRegionId,
      orElse: () => MockData.regions.first,
    );
    final isVisited = passport.isStateVisited(region.id);
    final regionDishes = MockData.dishes.where((d) => d.regionId == region.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${region.name} • Regional Passport'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // State Header Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isVisited
                      ? AppTheme.bananaLeafGreen
                      : AppTheme.darkCharcoal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${region.iconEmoji} ${region.name.toUpperCase()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            passport.toggleStateVisited(region.id);
                          },
                          icon: Icon(
                            isVisited ? Icons.check_circle : Icons.explore,
                            size: 16,
                          ),
                          label: Text(isVisited ? 'Explored' : 'Mark Explored'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isVisited ? AppTheme.turmericGold : Colors.white,
                            foregroundColor: AppTheme.darkCharcoal,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capital: ${region.capital}',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      region.shortDescription,
                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // State Switcher Carousel
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MockData.regions.length,
                  itemBuilder: (context, index) {
                    final r = MockData.regions[index];
                    final isSel = r.id == region.id;
                    final rVisited = passport.isStateVisited(r.id);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        selected: isSel,
                        showCheckmark: false,
                        label: Text('${r.iconEmoji} ${r.state}'),
                        selectedColor: AppTheme.terracotta,
                        backgroundColor: rVisited ? AppTheme.chipBackground : Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSel ? Colors.white : AppTheme.darkCharcoal,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (_) {
                          context.go('/passport/${r.id}');
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Regional Story
              Text(
                'Culinary Story of ${region.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    region.fullStory,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.darkCharcoal),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Chef's Note (Unlocked if 3 dishes tried or state explored)
              Text(
                "Chef Nandana's Personal Note",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Card(
                color: AppTheme.sandBackground,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppTheme.terracotta,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nandana Hazarika',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              region.chefNote,
                              style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dishes from this State
              Text(
                'Dishes from ${region.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (regionDishes.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Chef special dishes for this region unlock seasonally!'),
                    ),
                  ),
                )
              else
                ...regionDishes.map(
                  (dish) => DishCard(
                    dish: dish,
                    onTap: () => context.push('/dish/${dish.id}'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
