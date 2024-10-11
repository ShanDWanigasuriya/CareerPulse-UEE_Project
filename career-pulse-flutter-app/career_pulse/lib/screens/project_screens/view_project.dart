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
    futureProject = ProjectService().getProjectById(widget.projectId);
  }

  Future<void> downloadFile(String url, String filename) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/$filename';

      Dio dio = Dio();
      await dio.download(url, savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to $savePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
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

          final project = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section with Title and Background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF001F54),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.projectName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Status label with color
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: _getStatusColor(project.projectStatus),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getStatusLabel(project.projectStatus),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Description Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.projectDescription,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Dates Section (Start Date only as per your preference)
                      Text(
                        'Start Date: ${project.startDate.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Document Download Button
                if (project.projectDocumentUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          downloadFile(
                            'https://bf89-2402-4000-b280-ec7-619c-76b7-41-24fd.ngrok-free.app${project.projectDocumentUrl!}',
                            project.projectDocumentUrl!.split('/').last,
                          );
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download Document'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 32), // Bottom padding
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to map status integer to label
  String _getStatusLabel(int status) {
    switch (status) {
      case 1:
        return 'Ongoing';
      case 2:
        return 'Completed';
      case 3:
        return 'Upcoming';
      default:
        return 'Unknown';
    }
  }

  // Helper method to get the corresponding status color
  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.orange; // Ongoing: Warning color
      case 2:
        return Colors.green; // Completed: Green
      case 3:
        return Colors.black; // Upcoming: Black
      default:
        return Colors.grey; // Unknown: Grey
    }
  }
}
