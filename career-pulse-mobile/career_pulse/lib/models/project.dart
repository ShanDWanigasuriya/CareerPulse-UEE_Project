import 'dart:io'; // For File handling

class Project {
  int projectId;
  int collaboratorId;
  String projectName;
  String projectDescription;
  int projectStatus; // Using int instead of enum
  DateTime startDate;
  DateTime endDate;
  File? projectDocument;
  String? projectDocumentUrl;

  Project({
    required this.projectId,
    required this.collaboratorId,
    required this.projectName,
    required this.projectDescription,
    required this.projectStatus,
    required this.startDate,
    required this.endDate,
    this.projectDocument,
    this.projectDocumentUrl,
  });

  // Convert a JSON Map into a Project instance
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['projectId'],
      collaboratorId: json['collaboratorId'],
      projectName: json['projectName'] ?? '',
      projectDescription: json['projectDescription'] ?? '',
      projectStatus: json['projectStatusEnum'], // Handling as an int
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      projectDocument: json['projectDocument'] != null
          ? File(json['projectDocument'])
          : null,
      projectDocumentUrl: json['projectDocumentUrl'], // Adding projectDocumentUrl
    );
  }

  // Convert a Project instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'collaboratorId': collaboratorId,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'projectStatusEnum': projectStatus, // Using int directly
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'projectDocument': projectDocument?.path,
      'projectDocumentUrl': projectDocumentUrl, // Including projectDocumentUrl
    };
  }
}
