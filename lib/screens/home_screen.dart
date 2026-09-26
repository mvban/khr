import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../services/toast_reservation_service.dart';
import '../widgets/passport_map_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todaysSpecial = MockData.dishes.firstWhere((d) => d.id == 'd1');

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'KHAAR',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const Text(
              'SUNNYVALE',
              style: TextStyle(fontSize: 10, letterSpacing: 2, color: AppTheme.turmericGold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_rounded),
            onPressed: () => context.push('/favourites'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner with Reserve CTA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.terracotta, AppTheme.terracottaLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.terracotta.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'NOT ANOTHER RESTAURANT APP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Discover Northeast India,\nOne Dish at a Time.',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Grand Opening: Sept 12, 2026 • 193–195 S Murphy Ave',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => ToastReservationService.reserveTable(context),
                        icon: const Icon(Icons.table_restaurant_rounded, color: AppTheme.darkCharcoal),
                        label: const Text(
                          'RESERVE A TABLE (TOAST)',
                          style: TextStyle(
                            color: AppTheme.darkCharcoal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.turmericGold,
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Regional Passport Map Section
              PassportMapWidget(
                onStateTap: (regionId) {
                  context.push('/passport/$regionId');
                },
              ),
              const SizedBox(height: 24),

              // Quick Feature Navigation Grid
              Text(
                'Explore Khaar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildNavCard(
                    context,
                    icon: Icons.restaurant_menu_rounded,
                    title: 'Menu',
                    color: AppTheme.terracotta,
                    onTap: () => context.push('/menu'),
                  ),
                  _buildNavCard(
                    context,
                    icon: Icons.local_bar_rounded,
                    title: 'Bar & Wines',
                    color: AppTheme.bananaLeafGreen,
                    onTap: () => context.push('/bar'),
                  ),
                  _buildNavCard(
                    context,
                    icon: Icons.menu_book_rounded,
                    title: 'Ingredients',
                    color: AppTheme.turmericGold,
                    onTap: () => context.push('/ingredients'),
                  ),
                  _buildNavCard(
                    context,
                    icon: Icons.auto_stories_rounded,
                    title: 'The Story',
                    color: AppTheme.terracotta,
                    onTap: () => context.push('/story'),
                  ),
                  _buildNavCard(
                    context,
                    icon: Icons.event_available_rounded,
                    title: 'Events',
                    color: AppTheme.bananaLeafGreen,
                    onTap: () => context.push('/events'),
                  ),
                  _buildNavCard(
                    context,
                    icon: Icons.room_service_rounded,
                    title: 'Catering',
                    color: AppTheme.turmericGold,
                    onTap: () => context.push('/catering'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Today's Chef Pick Card
              Text(
                "Chef Nandana's Special",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.bananaLeafGreen,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'TODAY\'S PICK',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '\$${todaysSpecial.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.terracotta),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        todaysSpecial.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        todaysSpecial.shortDescription,
                        style: const TextStyle(color: AppTheme.mutedText, fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () => context.push('/dish/${todaysSpecial.id}'),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: AppTheme.terracotta),
                            label: const Text(
                              'Read Dish Story',
                              style: TextStyle(color: AppTheme.terracotta, fontWeight: FontWeight.bold),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => ToastReservationService.reserveTable(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: const Text('Order/Reserve'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Contact & Map Footer Quick Button
              OutlinedButton.icon(
                onPressed: () => context.push('/contact'),
                icon: const Icon(Icons.location_on_rounded),
                label: const Text('View Hours, Location & Directions'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkCharcoal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
