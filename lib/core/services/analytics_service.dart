// lib/core/services/analytics_service.dart
import 'package:flutter/foundation.dart';

abstract class AnalyticsService {
  Future<void> initialize();
  Future<void> trackEvent(String eventName, Map<String, dynamic> parameters);
  Future<void> trackUserProperty(String name, String value);
  Future<void> trackScreen(String screenName);
}

class AnalyticsServiceImpl implements AnalyticsService {
  @override
  Future<void> initialize() async {
    if (kDebugMode) {
      print('Analytics service initialized');
    }
  }

  @override
  Future<void> trackEvent(
    String eventName,
    Map<String, dynamic> parameters,
  ) async {
    if (kDebugMode) {
      print('Analytics Event: $eventName with parameters: $parameters');
    }
  }

  @override
  Future<void> trackUserProperty(String name, String value) async {
    if (kDebugMode) {
      print('Analytics User Property: $name = $value');
    }
  }

  @override
  Future<void> trackScreen(String screenName) async {
    if (kDebugMode) {
      print('Analytics Screen: $screenName');
    }
  }
}
