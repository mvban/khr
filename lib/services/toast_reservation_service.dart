import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app/constants/app_constants.dart';
import '../widgets/toast_dialog.dart';

class ToastReservationService {
  static Future<void> reserveTable(BuildContext context) async {
    final Uri toastUri = Uri.parse(AppConstants.toastReservationUrl);

    try {
      final bool launched = await launchUrl(
        toastUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        _showToastFallbackDialog(context);
      }
    } catch (_) {
      if (context.mounted) {
        _showToastFallbackDialog(context);
      }
    }
  }

  static void _showToastFallbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const ToastFallbackDialog(),
    );
  }

  static Future<void> openPlayStore() async {
    final Uri marketUri = Uri.parse(AppConstants.toastPlayStoreMarketUrl);
    final Uri webPlayStoreUri = Uri.parse(AppConstants.toastPlayStoreWebUrl);

    try {
      final bool launchedMarket = await launchUrl(
        marketUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launchedMarket) {
        await launchUrl(webPlayStoreUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      await launchUrl(webPlayStoreUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> openInBrowser() async {
    final Uri toastUri = Uri.parse(AppConstants.toastReservationUrl);
    await launchUrl(toastUri, mode: LaunchMode.externalApplication);
  }
}
