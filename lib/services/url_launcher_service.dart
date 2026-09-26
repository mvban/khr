import 'package:url_launcher/url_launcher.dart';
import '../app/constants/app_constants.dart';

class UrlLauncherService {
  static Future<void> openDirections() async {
    final Uri uri = Uri.parse(AppConstants.googleMapsDirectionsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> makePhoneCall() async {
    final Uri uri = Uri.parse(AppConstants.phoneTel);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> sendCateringEmail() async {
    final Uri uri = Uri.parse(AppConstants.cateringEmail);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> openInstagram() async {
    final Uri uri = Uri.parse(AppConstants.instagramUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> openWebsite() async {
    final Uri uri = Uri.parse(AppConstants.websiteUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
