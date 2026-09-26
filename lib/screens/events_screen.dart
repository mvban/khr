import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';
import '../data/mock_data.dart';
import '../services/toast_reservation_service.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Events & Tastings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.events.length,
        itemBuilder: (context, index) {
          final event = MockData.events[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.terracotta,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${event.date.month}/${event.date.day}/${event.date.year}',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        event.time,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.mutedText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    event.subtitle,
                    style: const TextStyle(fontSize: 14, color: AppTheme.bananaLeafGreen, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 13, color: AppTheme.mutedText, height: 1.4),
                  ),
                  const SizedBox(height: 14),

                  // Menu Preview Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.sandBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.borderGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('MENU PREVIEW:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                        const SizedBox(height: 2),
                        Text(event.menuPreview, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => ToastReservationService.reserveTable(context),
                      icon: const Icon(Icons.event_seat_rounded),
                      label: const Text('RESERVE EVENT TICKET (TOAST)'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
