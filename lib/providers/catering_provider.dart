import 'package:flutter/foundation.dart';

class CateringProvider extends ChangeNotifier {
  String _eventType = 'Corporate Dinner';
  int _guestCount = 30;
  DateTime _eventDate = DateTime.now().add(const Duration(days: 14));
  List<String> _selectedDietaryNeeds = ['GF Options'];
  String _specialRequests = '';
  bool _isSubmitted = false;

  String get eventType => _eventType;
  int get guestCount => _guestCount;
  DateTime get eventDate => _eventDate;
  List<String> get selectedDietaryNeeds => _selectedDietaryNeeds;
  String get specialRequests => _specialRequests;
  bool get isSubmitted => _isSubmitted;

  void setEventType(String type) {
    _eventType = type;
    notifyListeners();
  }

  void setGuestCount(int count) {
    _guestCount = count;
    notifyListeners();
  }

  void setEventDate(DateTime date) {
    _eventDate = date;
    notifyListeners();
  }

  void toggleDietaryNeed(String need) {
    if (_selectedDietaryNeeds.contains(need)) {
      _selectedDietaryNeeds.remove(need);
    } else {
      _selectedDietaryNeeds.add(need);
    }
    notifyListeners();
  }

  void setSpecialRequests(String requests) {
    _specialRequests = requests;
    notifyListeners();
  }

  void submitInquiry() {
    _isSubmitted = true;
    notifyListeners();
  }

  void resetForm() {
    _isSubmitted = false;
    _specialRequests = '';
    notifyListeners();
  }
}
