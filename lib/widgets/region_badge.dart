import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';

class RegionBadge extends StatelessWidget {
  final String regionName;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const RegionBadge({
    super.key,
    required this.regionName,
    this.isUnlocked = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isUnlocked
              ? AppTheme.bananaLeafGreen.withOpacity(0.12)
              : Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUnlocked
                ? AppTheme.bananaLeafGreen.withOpacity(0.4)
                : Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUnlocked ? Icons.verified_rounded : Icons.lock_outline_rounded,
              size: 13,
              color: isUnlocked ? AppTheme.bananaLeafGreen : Colors.grey.shade600,
            ),
            const SizedBox(width: 5),
            Text(
              regionName.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
                color: isUnlocked ? AppTheme.bananaLeafGreen : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
