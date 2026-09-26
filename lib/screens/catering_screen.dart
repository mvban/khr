import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme/app_theme.dart';
import '../providers/catering_provider.dart';

class CateringScreen extends StatelessWidget {
  const CateringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catering = context.watch<CateringProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catering & Private Dining'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.terracotta,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bring Khaar to Your Event',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'From intimate 15-person tasting dinners to corporate galas of 150+, we craft customized Northeast Indian culinary journeys.',
                      style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Catering Packages Section
              Text(
                'Pre-Built Catering Packages',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _buildPackageCard(
                context,
                title: 'Vegetarian Heritage Journey',
                price: '\$45 / guest',
                items: 'Khaar Croquette • Manipuri Eromba Bowl • Assam Tea Crème Brûlée',
              ),
              _buildPackageCard(
                context,
                title: 'Signature Northeast Experience',
                price: '\$65 / guest',
                items: 'Khaar Croquette • Bamboo Blaze • Black Sesame Heritage • Desserts',
              ),
              const SizedBox(height: 28),

              // Catering Form Section
              Text(
                'Inquire for Catering',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (catering.isSubmitted)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.bananaLeafGreen.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.bananaLeafGreen),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppTheme.bananaLeafGreen, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        'Inquiry Received!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkCharcoal),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Thank you! Chef Nandana and our catering team will contact you within 24 hours regarding your ${catering.eventType} event.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => catering.resetForm(),
                        child: const Text('Submit Another Inquiry'),
                      ),
                    ],
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Type Dropdown
                        const Text('Event Type', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: catering.eventType,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppTheme.sandBackground,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          items: ['Corporate Dinner', 'Wedding Reception', 'Birthday / Private Party', 'Chef Tasting Table']
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) catering.setEventType(val);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Guest Count Slider
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Estimated Guests', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${catering.guestCount} guests', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.terracotta)),
                          ],
                        ),
                        Slider(
                          value: catering.guestCount.toDouble(),
                          min: 10,
                          max: 150,
                          divisions: 14,
                          activeColor: AppTheme.terracotta,
                          label: '${catering.guestCount}',
                          onChanged: (val) => catering.setGuestCount(val.toInt()),
                        ),
                        const SizedBox(height: 16),

                        // Special Notes
                        const Text('Dietary Needs & Special Requests', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextField(
                          onChanged: (val) => catering.setSpecialRequests(val),
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Specify GF, DF, vegan preferences, or specific regional menu items...',
                            filled: true,
                            fillColor: AppTheme.sandBackground,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => catering.submitInquiry(),
                            icon: const Icon(Icons.send_rounded),
                            label: const Text('SUBMIT CATERING INQUIRY'),
                          ),
                        ),
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

  Widget _buildPackageCard(BuildContext context, {required String title, required String price, required String items}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.turmericGold.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.stars_rounded, color: AppTheme.darkCharcoal),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.terracotta, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(items, style: const TextStyle(fontSize: 12, color: AppTheme.mutedText)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
