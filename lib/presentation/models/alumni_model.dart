class AlumniModel {
  final String name;
  final String position;
  final String company;
  final String program;
  final String graduationYear;
  final String location;
  final List<String> skills;
  final bool isConnected;
  final bool isRecentlyActive;

  AlumniModel({
    required this.name,
    required this.position,
    required this.company,
    required this.program,
    required this.graduationYear,
    required this.location,
    required this.skills,
    this.isConnected = false,
    this.isRecentlyActive = false,
  });
}
