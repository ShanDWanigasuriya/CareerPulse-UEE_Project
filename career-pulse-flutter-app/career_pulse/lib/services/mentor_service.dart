import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/mentor.dart'; // Import your Mentor model
import './global_settings.dart';

class MentorService {
  Future<bool> createMentor(Mentorsip mentor, File? mentorDocument) async {
    var uri = Uri.parse('$baseApiUrl/Mentor/CreateMentor');
    var request = http.MultipartRequest('POST', uri);

    // Add the mentor fields as part of the form data
    request.fields['mentorId'] = mentor.mentorId.toString();
    request.fields['collaboratorId'] = mentor.collaboratorId.toString();
    request.fields['mentorName'] = mentor.mentorName;
    request.fields['mentorDescription'] = mentor.mentorDescription;
    request.fields['experience'] = mentor.experience;
    request.fields['expertise'] = mentor.expertise;

    // Attach the mentor document if available
    if (mentorDocument != null) {
      var mimeType = lookupMimeType(mentorDocument.path);
      var fileStream = http.ByteStream(mentorDocument.openRead());
      var fileLength = await mentorDocument.length();

      request.files.add(
        http.MultipartFile(
          'mentorDocument',
          fileStream,
          fileLength,
          filename: mentorDocument.path.split('/').last,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        ),
      );
    }

    // Send the request
    var response = await request.send();

    // Check for success response
    if (response.statusCode == 201) {
      return true; // Successful mentor creation
    } else {
      return false; // Mentor creation failed
    }
  }

  // Method to fetch all mentors
  Future<List<Mentorsip>> getAllMentors() async {
    var uri = Uri.parse('$baseApiUrl/Mentor/GetAllMentors');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((mentor) => Mentorsip.fromJson(mentor)).toList();
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  // Method to get a mentor by ID
  Future<Mentorsip> getMentorById(int mentorId) async {
    var uri = Uri.parse(
        '$baseApiUrl/Mentor/GetMentorById?mentorId=$mentorId'); // Adjust your endpoint
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      return Mentorsip.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load mentor');
    }
  }
}
