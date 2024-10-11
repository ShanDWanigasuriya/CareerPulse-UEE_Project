import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../services/project_service.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ViewProject extends StatefulWidget {
  final int projectId;

  const ViewProject({Key? key, required this.projectId}) : super(key: key);

  @override
  _ViewProjectState createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  late Future<Project> futureProject;

  @override
  void initState() {
    super.initState();
    futureProject = ProjectService()
        .getProjectById(widget.projectId); // Fetch project details by ID
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
        title: const Text('Project Details'),
      ),
      body: FutureBuilder<Project>(
        future: futureProject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No project found'));
          }

          // Project loaded successfully
          final project = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.projectName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  project.projectDescription,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Status: ${project.projectStatus}', // Map this to meaningful status names as needed
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Start Date: ${project.startDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'End Date: ${project.endDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
                if (project.projectDocumentUrl != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      downloadFile(
                        'https://bf89-2402-4000-b280-ec7-619c-76b7-41-24fd.ngrok-free.app${project.projectDocumentUrl!}',
                        project.projectDocumentUrl!.split('/').last, // Use the last part of the URL as the filename
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
