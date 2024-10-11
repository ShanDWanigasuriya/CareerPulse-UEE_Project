import 'dart:io'; // For file handling

class Event {
  int eventId; // Nullable integer for EventId
  String eventTitle; // Non-nullable string for EventTitle
  String eventDescription; // Non-nullable string for EventDescription
  String eventVenue; // Non-nullable string for EventVenueEnm
  String eventLink; // Non-nullable string for EventLink
  String eventImageUrl; // Non-nullable string for EventImageUrl
  DateTime startDate; // Non-nullable DateTime for StartDate
  DateTime endDate; // Non-nullable DateTime for EndDate
  File? eventDocument; // Nullable File for EventDocument

  Event({
    required this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventVenue,
    required this.eventLink,
    required this.eventImageUrl,
    required this.startDate,
    required this.endDate,
    this.eventDocument,
  });

  // Convert a JSON Map into an Event instance
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'] as int,
      eventTitle: json['eventTitle'] as String? ?? '',
      eventDescription: json['eventDescription'] as String? ?? '',
      eventVenue: json['eventVenueEnm'] as String? ?? '',
      eventLink: json['eventLink'] as String? ?? '',
      eventImageUrl: json['eventImageUrl'] as String? ?? '',
      startDate: DateTime.parse(json['startDate']), // Parse to DateTime
      endDate: DateTime.parse(json['endDate']), // Parse to DateTime
      eventDocument: json['eventDocument'] != null ? File(json['eventDocument']) : null, // Handle file
    );
  }

  // Convert an Event instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventVenueEnm': eventVenue,
      'eventLink': eventLink,
      'eventImageUrl': eventImageUrl,
      'startDate': startDate.toIso8601String(), // Convert to ISO 8601 String
      'endDate': endDate.toIso8601String(), // Convert to ISO 8601 String
      'eventDocument': eventDocument?.path, // Get the path of the file
    };
  }
}
