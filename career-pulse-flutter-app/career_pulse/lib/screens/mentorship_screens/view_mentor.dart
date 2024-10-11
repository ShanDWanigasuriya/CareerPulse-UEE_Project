import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/mentor.dart'; // Import your Mentor model
import '../../services/mentor_service.dart'; // Import your Mentor service
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ViewMentor extends StatefulWidget {
  final int mentorId;

  const ViewMentor({Key? key, required this.mentorId}) : super(key: key);

  @override
  _ViewMentorState createState() => _ViewMentorState();
}

class _ViewMentorState extends State<ViewMentor> {
  late Future<Mentorsip> futureMentor;

  @override
  void initState() {
    super.initState();
    futureMentor = MentorService()
        .getMentorById(widget.mentorId); // Fetch mentor details by ID
  }

  Future<void> downloadFile(String url, String filename) async {
    try {
      // Get the directory to save the file
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/$filename';

      // Create a Dio instance
      Dio dio = Dio();

      // Start the download
      await dio.download(url, savePath);

      // Show a success message after download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to $savePath')),
      );
    } catch (e) {
      final error = e;
      // Handle any errors during download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Details'),
      ),
      body: FutureBuilder<Mentorsip>(
        future: futureMentor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No mentor found'));
          }

          // Mentor loaded successfully
          final mentor = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mentor.mentorName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  mentor.mentorDescription,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Experience: ${mentor.experience}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Expertise: ${mentor.expertise}',
                  style: const TextStyle(fontSize: 16),
                ),
                if (mentor.mentorDocument != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      downloadFile(
                        'https://your_api_base_url/${mentor.mentorDocumentUrl!}', // Use your actual base URL
                        mentor.mentorDocumentUrl!
                            .split('/')
                            .last, // Use the last part of the URL as the filename
                      );
                    },
                    child: const Text('Download Document'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
