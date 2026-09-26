class Event {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final String time;
  final String description;
  final String menuPreview;
  final String toastReservationUrl;
  final bool isPast;

  const Event({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.description,
    required this.menuPreview,
    required this.toastReservationUrl,
    this.isPast = false,
  });
}
