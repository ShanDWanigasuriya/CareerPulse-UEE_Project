import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/event.dart'; // Assuming you have the Event model
import './global_settings.dart'; // Assuming you have global settings for the base API URL

class EventService {
  // Method to create an event
  Future<bool> createEvent(Event event, File? eventDocument) async {
    var uri = Uri.parse('$baseApiUrl/Event/CreateEvent');
    var request = http.MultipartRequest('POST', uri);

    // Add the event fields as part of the form data
    request.fields['eventId'] = '0'; // Assuming 0 is used for a new event
    request.fields['eventTitle'] = event.eventTitle;
    request.fields['eventDescription'] = event.eventDescription;
    request.fields['eventVenue'] = event.eventVenue;
    request.fields['eventLink'] = event.eventLink;
    request.fields['eventImageUrl'] = event.eventImageUrl;
    request.fields['startDate'] = event.startDate.toIso8601String(); // Convert DateTime to ISO 8601 String
    request.fields['endDate'] = event.endDate.toIso8601String();

    // Attach the event document if available
    if (eventDocument != null) {
      var mimeType = lookupMimeType(eventDocument.path);
      var fileStream = http.ByteStream(eventDocument.openRead());
      var fileLength = await eventDocument.length();

      request.files.add(
        http.MultipartFile(
          'eventDocument', // Ensure this matches the parameter name in your API
          fileStream,
          fileLength,
          filename: eventDocument.path.split('/').last,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        ),
      );
    }

    // Send the request
    var response = await request.send();

    // Check for success response
    if (response.statusCode == 201) {
      return true; // Successful event creation
    } else {
      return false; // Event creation failed
    }
  }

  // Method to fetch all events
  Future<List<Event>> getAllEvents() async {
    var uri = Uri.parse('$baseApiUrl/Event/GetAllEvents');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  // Method to fetch an event by ID
  Future<Event> getEventById(int eventId) async {
    var uri = Uri.parse('$baseApiUrl/Event/GetEventById?eventId=$eventId');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load event');
    }
  }
}
