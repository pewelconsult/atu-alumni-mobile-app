import 'package:flutter/material.dart';

class EventModel {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String category;
  final Color categoryColor;
  final int attendeesCount;
  final bool isRSVPed;
  final bool isPastEvent;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.categoryColor,
    required this.attendeesCount,
    this.isRSVPed = false,
    this.isPastEvent = false,
  });
}
