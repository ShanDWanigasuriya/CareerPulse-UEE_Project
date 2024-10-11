import 'dart:io'; // For File handling

class Mentorsip {
  // Mentor properties
  final int mentorshipId;
  final int mentorId; // Unique ID for the mentor
  final int collaboratorId; // ID for the collaborator
  final String mentorshipTitle; // Name of the mentor
  final String mentorshipDescription; // Description of the mentor
  final String mentorName; // Name of the mentor
  final String mentorDescription; // Description of the mentor
  final String experience; // Experience level of the mentor
  final String expertise; // Area of expertise of the mentor
  final bool isAvailable; // Availability status of the mentor
  final File? mentorDocument; // Document related to the mentor
  final String? mentorDocumentUrl; // URL for the mentor document

  // For managing multiple time slots
  final List<Map<String, dynamic>> timeSlots;

  // Constructor for the Mentor class
  Mentorsip({
    required this.mentorshipId,
    required this.mentorId,
    required this.collaboratorId,
    required this.mentorshipTitle,
    required this.mentorshipDescription,
    required this.mentorName,
    required this.mentorDescription,
    required this.experience,
    required this.expertise,
    required this.isAvailable,
    this.mentorDocument,
    this.mentorDocumentUrl,
    List<Map<String, dynamic>>? timeSlots,
  }) : timeSlots =
            timeSlots ?? []; // Initialize timeSlots with an empty list if null

  // Convert a JSON Map into a Mentor instance
  factory Mentorsip.fromJson(Map<String, dynamic> json) {
    return Mentorsip(
      mentorshipId: json['mentorshipId'],
      mentorId: json['mentorId'],
      collaboratorId: json['collaboratorId'],
      mentorshipTitle: json['mentorshipTitle'] ?? '',
      mentorshipDescription: json['mentorshipDescription'] ?? '',
      mentorName: json['mentorName'] ?? '',
      mentorDescription: json['mentorDescription'] ?? '',
      experience: json['experience'] ?? '',
      expertise: json['expertise'] ?? '',
      isAvailable:
          json['isAvailable'] ?? false, // Default value for isAvailable
      mentorDocument:
          json['mentorDocument'] != null ? File(json['mentorDocument']) : null,
      mentorDocumentUrl: json['mentorDocumentUrl'], // Adding mentorDocumentUrl
      timeSlots: List<Map<String, dynamic>>.from(json['timeSlots'] ?? []),
    );
  }

  // Convert a Mentor instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'mentorshipId': mentorshipId,
      'mentorId': mentorId,
      'collaboratorId': collaboratorId,
      'mentorshipTitle': mentorshipTitle,
      'mentorshipDescription': mentorshipDescription,
      'mentorName': mentorName,
      'mentorDescription': mentorDescription,
      'experience': experience,
      'expertise': expertise,
      'isAvailable': isAvailable, // Include availability status in JSON
      'mentorDocument': mentorDocument?.path, // Path to the mentor document
      'mentorDocumentUrl': mentorDocumentUrl, // Including mentorDocumentUrl
      'timeSlots': timeSlots, // Convert time slots to JSON
    };
  }
}
