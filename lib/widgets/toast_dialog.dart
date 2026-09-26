import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';
import '../services/toast_reservation_service.dart';

class ToastFallbackDialog extends StatelessWidget {
  const ToastFallbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.sandBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(Icons.get_app_rounded, color: AppTheme.terracotta, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Toast App Not Installed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'The Toast app is not installed on your phone. How would you like to proceed?',
            style: TextStyle(fontSize: 14, height: 1.4, color: AppTheme.darkCharcoal),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderGrey),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded, color: AppTheme.bananaLeafGreen, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Direct ordering & instant reservations work best with the Toast app.',
                    style: TextStyle(fontSize: 12, color: AppTheme.mutedText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.all(16),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Option 1: Download Toast from Play Store
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ToastReservationService.openPlayStore();
              },
              icon: const Icon(Icons.shop_two_rounded),
              label: const Text('1) Download Toast from Play Store'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.bananaLeafGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 10),

            // Option 2: Open in Browser
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ToastReservationService.openInBrowser();
              },
              icon: const Icon(Icons.open_in_browser_rounded),
              label: const Text('2) Open in Browser'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.terracotta,
                side: const BorderSide(color: AppTheme.terracotta, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 4),

            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.mutedText)),
            ),
          ],
        ),
      ],
    );
  }
}
