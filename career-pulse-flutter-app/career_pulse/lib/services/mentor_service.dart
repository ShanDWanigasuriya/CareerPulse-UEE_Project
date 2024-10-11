import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/mentor.dart'; // Import your Mentor model
import './global_settings.dart'; // Assuming you have baseApiUrl defined here

class MentorService {
  Future<bool> createMentor(Mentorship mentor, File? mentorDocument) async {
    var uri = Uri.parse('$baseApiUrl/Mentorship/CreateMentorship');
    var request = http.MultipartRequest('POST', uri);

    // Add the mentor fields as part of the form data
    request.fields['mentorshipId'] = mentor.mentorshipId?.toString() ?? '0';  // Default to '0' for new mentorships
    request.fields['mentorshipTitle'] = mentor.mentorshipTitle;
    request.fields['mentorshipDescription'] = mentor.mentorshipDescription;
    request.fields['mentorName'] = mentor.mentorName;
    request.fields['mentorDescription'] = mentor.mentorDescription;
    request.fields['mentorExperience'] = mentor.mentorExperience;
    request.fields['mentorExpertise'] = mentor.mentorExpertise;

    // Attach the mentor document if available
    if (mentorDocument != null) {
      var mimeType = lookupMimeType(mentorDocument.path) ?? 'application/octet-stream';
      var fileStream = http.ByteStream(mentorDocument.openRead());
      var fileLength = await mentorDocument.length();

      request.files.add(
        http.MultipartFile(
          'mentorDocument', // Name of the file field in the API
          fileStream,
          fileLength,
          filename: mentorDocument.path.split('/').last,
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        return true; // Mentor created successfully
      } else {
        return false; // Mentor creation failed
      }
    } catch (e) {
      return false;
    }
  }

  // Method to get all mentorship details
  Future<List<Mentorship>> getAllMentorships() async {
    final response = await http.get(Uri.parse('$baseApiUrl/Mentorship/GetAllMentorships'));
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Mentorship.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mentorships');
    }
  }

  // Method to get a specific mentorship by ID
  Future<Mentorship> getMentorshipById(int mentorshipId) async {
    final response = await http.get(Uri.parse('$baseApiUrl/Mentorship/GetMentorshipsById?mentorshipId=$mentorshipId'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Mentorship.fromJson(jsonData); // Return the Mentorship object
    } else {
      throw Exception('Failed to load mentorship with ID: $mentorshipId');
    }
  }
}
