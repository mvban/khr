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
          Icon(Icons.restaurant_menu_rounded, color: AppTheme.terracotta, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Reserve via Toast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
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
            'Toast App is not installed on your device or could not be launched directly.',
            style: TextStyle(fontSize: 15, height: 1.4),
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
                Icon(Icons.info_outline, color: AppTheme.bananaLeafGreen, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Choose how you would like to complete your table reservation:',
                    style: TextStyle(fontSize: 13, color: AppTheme.mutedText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ToastReservationService.openInBrowser();
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in Browser'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.terracotta,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ToastReservationService.openPlayStore();
              },
              icon: const Icon(Icons.android),
              label: const Text('Install from Google Play'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.bananaLeafGreen,
                side: const BorderSide(color: AppTheme.bananaLeafGreen, width: 1.5),
              ),
            ),
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
