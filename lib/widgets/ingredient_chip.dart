import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';

class IngredientChip extends StatelessWidget {
  final String label;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const IngredientChip({
    super.key,
    required this.label,
    this.isUnlocked = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isUnlocked ? AppTheme.chipBackground : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUnlocked ? AppTheme.borderGrey : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUnlocked ? Icons.eco_outlined : Icons.lock_outline,
              size: 13,
              color: isUnlocked ? AppTheme.terracotta : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isUnlocked ? AppTheme.darkCharcoal : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
