import 'package:flutter/material.dart';
import '../app/constants/app_constants.dart';
import '../app/theme/app_theme.dart';
import '../services/toast_reservation_service.dart';
import '../services/url_launcher_service.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address & Location Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppTheme.terracotta,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.appName,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  AppConstants.address,
                                  style: TextStyle(fontSize: 13, color: AppTheme.mutedText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 16),

                      // Quick Contact Action Grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildActionButton(
                            icon: Icons.directions_rounded,
                            label: 'Directions',
                            color: AppTheme.terracotta,
                            onTap: () => UrlLauncherService.openDirections(),
                          ),
                          _buildActionButton(
                            icon: Icons.phone_rounded,
                            label: 'Call Us',
                            color: AppTheme.bananaLeafGreen,
                            onTap: () => UrlLauncherService.makePhoneCall(),
                          ),
                          _buildActionButton(
                            icon: Icons.camera_alt_rounded,
                            label: 'Instagram',
                            color: Colors.purple.shade700,
                            onTap: () => UrlLauncherService.openInstagram(),
                          ),
                          _buildActionButton(
                            icon: Icons.table_restaurant_rounded,
                            label: 'Reserve',
                            color: AppTheme.turmericGold,
                            onTap: () => ToastReservationService.reserveTable(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Opening Hours Table
              Text(
                'Opening Hours',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildHourRow('Monday – Thursday', '5:00 PM – 10:00 PM'),
                      const Divider(),
                      _buildHourRow('Friday', '5:00 PM – 11:00 PM'),
                      const Divider(),
                      _buildHourRow('Saturday', '11:30 AM – 11:00 PM'),
                      const Divider(),
                      _buildHourRow('Sunday', '11:30 AM – 9:30 PM'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Restaurant Info Table
              Text(
                'Restaurant Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow('Chef / Founder', AppConstants.chefFounder),
                      const Divider(),
                      _buildInfoRow('Co-founder', AppConstants.coFounder),
                      const Divider(),
                      _buildInfoRow('Grand Opening', AppConstants.grandOpening),
                      const Divider(),
                      _buildInfoRow('Seating Capacity', AppConstants.capacity),
                      const Divider(),
                      _buildInfoRow('Catering Email', 'hello@khaarsunnyvale.com'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourRow(String days, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(days, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          Text(hours, style: const TextStyle(color: AppTheme.terracotta, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.mutedText)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
