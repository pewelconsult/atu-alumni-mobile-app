// lib/core/services/notification_service.dart
import 'package:flutter/foundation.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<void> showNotification(String title, String body);
  Future<void> scheduleNotification(
    String title,
    String body,
    DateTime scheduledDate,
  );
  Future<void> cancelAllNotifications();
}

class NotificationServiceImpl implements NotificationService {
  @override
  Future<void> initialize() async {
    if (kDebugMode) {
      print('Notification service initialized');
    }
  }

  @override
  Future<void> showNotification(String title, String body) async {
    if (kDebugMode) {
      print('Notification: $title - $body');
    }
  }

  @override
  Future<void> scheduleNotification(
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    if (kDebugMode) {
      print('Scheduled Notification: $title - $body at $scheduledDate');
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    if (kDebugMode) {
      print('All notifications cancelled');
    }
  }
}
