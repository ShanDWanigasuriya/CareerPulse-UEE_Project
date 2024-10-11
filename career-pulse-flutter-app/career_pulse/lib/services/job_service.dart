import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/job.dart'; // Assuming you have the Job model
import './global_settings.dart'; // Assuming you have global settings for the base API URL

class JobService {
  Future<bool> createJob(Job job, File? jobDocument) async {
    var uri = Uri.parse('$baseApiUrl/Job/CreateJob');
    var request = http.MultipartRequest('POST', uri);

    // Add the job fields as part of the form data
    
    request.fields['jobId'] = '0';
    request.fields['jobTitle'] = job.jobTitle;
    request.fields['jobDecription'] = job.jobDescription;
    request.fields['jobTypeEnum'] = job.jobTypeEnum;

    // Attach the job document if available
    if (jobDocument != null) {
      var mimeType = lookupMimeType(jobDocument.path);
      var fileStream = http.ByteStream(jobDocument.openRead());
      var fileLength = await jobDocument.length();

      request.files.add(
        http.MultipartFile(
          'document',
          fileStream,
          fileLength,
          filename: jobDocument.path.split('/').last,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        ),
      );
    }

    // Send the request
    var response = await request.send();

    // Check for success response
    if (response.statusCode == 201) {
      return true; // Successful job creation
    } else {
      return false; // Job creation failed
    }
  }

  // Method to fetch all jobs
  Future<List<Job>> getAllJobs() async {
    var uri = Uri.parse('$baseApiUrl/Job/GetAllJobs');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  // Method to fetch a job by ID
  Future<Job> getJobById(int jobId) async {
    var uri = Uri.parse('$baseApiUrl/Job/GetJobById?jobId=$jobId');
    var response = await http.get(uri);

    // Check for success response
    if (response.statusCode == 200) {
      return Job.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load job');
    }
  }
}
