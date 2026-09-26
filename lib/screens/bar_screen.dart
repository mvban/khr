import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/cocktail.dart';
import '../providers/favourites_provider.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({super.key});

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavouritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar & Beverage List'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.turmericGold,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Cocktails'),
            Tab(text: 'Mocktails'),
            Tab(text: 'Wines'),
            Tab(text: 'Draft Beer'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBeverageList(BeverageType.cocktail, favProvider),
          _buildBeverageList(BeverageType.mocktail, favProvider),
          _buildBeverageList(BeverageType.wine, favProvider),
          _buildBeverageList(BeverageType.draftBeer, favProvider),
        ],
      ),
    );
  }

  Widget _buildBeverageList(BeverageType type, FavouritesProvider favProvider) {
    final list = MockData.beverages.where((b) => b.type == type).toList();

    if (list.isEmpty) {
      return const Center(child: Text('No drinks in this category.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final isFav = favProvider.isBeverageFavourite(item.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.terracotta,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: isFav ? AppTheme.terracotta : AppTheme.mutedText,
                      ),
                      onPressed: () => favProvider.toggleBeverageFavourite(item.id),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 14, color: AppTheme.mutedText, height: 1.3),
                ),
                const SizedBox(height: 12),

                // Pairing suggestion
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.sandBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderGrey),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.restaurant_rounded, size: 14, color: AppTheme.bananaLeafGreen),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Pairs with: ${item.foodPairing}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.darkCharcoal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
