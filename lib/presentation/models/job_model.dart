import 'package:flutter/material.dart';

class JobModel {
  final String title;
  final String company;
  final String location;
  final String type;
  final String experienceLevel;
  final String salary;
  final String description;
  final List<String> requirements;
  final Color companyColor;
  final bool isSaved;
  final bool hasApplied;
  final String applicationStatus;
  final String postedBy;

  JobModel({
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.experienceLevel,
    required this.salary,
    required this.description,
    required this.requirements,
    required this.companyColor,
    this.isSaved = false,
    this.hasApplied = false,
    this.applicationStatus = 'Pending',
    required this.postedBy,
  });
}
