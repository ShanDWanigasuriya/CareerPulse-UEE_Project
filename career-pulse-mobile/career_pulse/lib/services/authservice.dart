import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/member.dart';
import './global_settings.dart';

class AuthService {

  Future<Member?> login(String username, String password) async {
    var response = await http.post(
      Uri.parse('$baseApiUrl/Member/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Member.fromJson(jsonDecode(response.body));
    } else {
      // Handle error
      return null;
    }
  }

  Future<bool> register(Member member, File? profileImage) async {
  var uri = Uri.parse('$baseApiUrl/Member/CreateMember');
  var request = http.MultipartRequest('POST', uri);

  // Add the member fields as part of the form data
  request.fields['userName'] = member.userName;
  request.fields['password'] = member.password;
  request.fields['email'] = member.email;
  request.fields['fullName'] = member.fullName;
  request.fields['memberType'] = member.memberType.toString(); // Send as string

  // Attach the profile image if available
  if (profileImage != null) {
    var mimeType = lookupMimeType(profileImage.path);
    var fileStream = http.ByteStream(profileImage.openRead());
    var fileLength = await profileImage.length();

    request.files.add(
      http.MultipartFile(
        'profileImage',
        fileStream,
        fileLength,
        filename: profileImage.path.split('/').last,
        contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
      ),
    );
  }

  // Send the request
  var response = await request.send();

  // Check for success response
  if (response.statusCode == 201) {
    return true; // Successful registration
  } else {
    return false; // Registration failed
  }
}

}
