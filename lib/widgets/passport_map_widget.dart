import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/passport_provider.dart';

class PassportMapWidget extends StatelessWidget {
  final Function(String regionId)? onStateTap;

  const PassportMapWidget({super.key, this.onStateTap});

  @override
  Widget build(BuildContext context) {
    final passport = context.watch<PassportProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.terracotta.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.explore_rounded, color: AppTheme.terracotta, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Regional Passport',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                      ),
                      Text(
                        'Discover the Seven Sisters + Assam',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: passport.hasKhaarExplorerBadge
                      ? AppTheme.turmericGold
                      : AppTheme.bananaLeafGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${passport.totalStatesExplored}/8 Unlocked',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: passport.hasKhaarExplorerBadge
                        ? Colors.black
                        : AppTheme.bananaLeafGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (passport.hasKhaarExplorerBadge)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.turmericGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.turmericGold),
              ),
              child: const Row(
                children: [
                  Icon(Icons.workspace_premium_rounded, color: AppTheme.darkCharcoal, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KHAAR EXPLORER BADGE UNLOCKED!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.darkCharcoal,
                          ),
                        ),
                        Text(
                          'You have explored all 8 states! Show this badge to your server for a complimentary chef tasting gift.',
                          style: TextStyle(fontSize: 11, color: AppTheme.darkCharcoal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // 8 States Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: MockData.regions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final region = MockData.regions[index];
              final isVisited = passport.isStateVisited(region.id);

              return InkWell(
                onTap: () {
                  if (onStateTap != null) {
                    onStateTap!(region.id);
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: isVisited
                        ? AppTheme.bananaLeafGreen.withOpacity(0.12)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isVisited
                          ? AppTheme.bananaLeafGreen
                          : Colors.grey.shade300,
                      width: isVisited ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        region.iconEmoji,
                        style: TextStyle(
                          fontSize: 22,
                          color: isVisited ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        region.state,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isVisited ? FontWeight.bold : FontWeight.w500,
                          color: isVisited ? AppTheme.darkCharcoal : Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
