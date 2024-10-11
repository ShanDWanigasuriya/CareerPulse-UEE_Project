import 'dart:io'; // For File handling

class Mentorship {
  // Properties matching the .NET model
  final int? mentorshipId;
  final String mentorshipTitle; // Title of the mentorship
  final String mentorshipDescription; // Description of the mentorship
  final String mentorName; // Name of the mentor
  final String mentorDescription; // Description of the mentor
  final String mentorExperience; // Mentor's experience
  final String mentorExpertise; // Mentor's expertise
  final File? mentorDocument; // Document related to the mentor
  final String? mentorDocumentUrl;

  // Constructor
  Mentorship({
    this.mentorshipId,
    required this.mentorshipTitle,
    required this.mentorshipDescription,
    required this.mentorName,
    required this.mentorDescription,
    required this.mentorExperience,
    required this.mentorExpertise,
    this.mentorDocument,
    this.mentorDocumentUrl
  });

  // Convert a JSON Map into a Mentorship instance
  factory Mentorship.fromJson(Map<String, dynamic> json) {
    return Mentorship(
      mentorshipId: json['mentorshipId'],
      mentorshipTitle: json['mentorshipTitle'] ?? '',
      mentorshipDescription: json['mentorshipDescription'] ?? '',
      mentorName: json['mentorName'] ?? '',
      mentorDescription: json['mentorDescription'] ?? '',
      mentorExperience: json['mentorExperience'] ?? '',
      mentorExpertise: json['mentorExpertise'] ?? '',
      mentorDocument: json['mentorDocument'] != null ? File(json['mentorDocument']) : null,
      mentorDocumentUrl: json['mentorDocumentUrl'] ?? '',
    );
  }

  // Convert a Mentorship instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'mentorshipId': mentorshipId,
      'mentorshipTitle': mentorshipTitle,
      'mentorshipDescription': mentorshipDescription,
      'mentorName': mentorName,
      'mentorDescription': mentorDescription,
      'mentorExperience': mentorExperience,
      'mentorExpertise': mentorExpertise,
      'mentorDocument': mentorDocument?.path, // Path to the mentor document
      'mentorDocumentUrl': mentorDocumentUrl,
    };
  }
}
