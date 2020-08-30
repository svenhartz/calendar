import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  Map<DateTime, List> events = {
    DateTime.now().subtract(Duration(days: 30)): [
      'Event A0',
      'Event B0',
      'Event C0'
    ],
  };

  void addEvent(DateTime date, String eventName) {
    if (events[date] == null) {
      events[date] = [eventName];
    } else {
      events[date].add(eventName);
    }
    notifyListeners();
    print(events);
  }
}
