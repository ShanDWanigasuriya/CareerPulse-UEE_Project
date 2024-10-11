import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/project.dart';
import './global_settings.dart';

class ProjectService {
  Future<bool> createProject(Project project, File? projectDocument) async {
    var uri = Uri.parse('$baseApiUrl/Project/CreateProject');
    var request = http.MultipartRequest('POST', uri);

    // Add the project fields as part of the form data
    request.fields['projectId'] = project.projectId.toString();
    request.fields['collaboratorId'] = project.collaboratorId.toString();
    request.fields['projectName'] = project.projectName;
    request.fields['projectDescription'] = project.projectDescription;
    request.fields['projectStatusEnum'] =
        project.projectStatus.toString(); // Send as string
    request.fields['startDate'] = project.startDate.toIso8601String();
    request.fields['endDate'] = project.endDate.toIso8601String();

    // Attach the project document if available
    if (projectDocument != null) {
      var mimeType = lookupMimeType(projectDocument.path);
      var fileStream = http.ByteStream(projectDocument.openRead());
      var fileLength = await projectDocument.length();

      request.files.add(
        http.MultipartFile(
          'projectDocument',
          fileStream,
          fileLength,
          filename: projectDocument.path.split('/').last,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        ),
      );
    }

    // Send the request
    var response = await request.send();

    // Check for success response
    if (response.statusCode == 201) {
      return true; // Successful project creation
    } else {
      return false; // Project creation failed
    }
  }

  // Method to fetch all projects
  Future<List<Project>> getAllProjects() async {
    var uri = Uri.parse('$baseApiUrl/Project/GetAllProjects');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  // Add this method in ProjectService
  Future<Project> getProjectById(int projectId) async {
    var uri = Uri.parse('$baseApiUrl/Project/GetProjectById?projectId=$projectId'); // Adjust your endpoint
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load project');
    }
  }
}
