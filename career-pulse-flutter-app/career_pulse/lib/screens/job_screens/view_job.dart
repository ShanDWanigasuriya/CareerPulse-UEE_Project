import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/job.dart'; // Replace with your Job model path
import '../../services/job_service.dart'; // Replace with your JobService path
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ViewJob extends StatefulWidget {
  final int jobId;

  const ViewJob({Key? key, required this.jobId}) : super(key: key);

  @override
  _ViewJobState createState() => _ViewJobState();
}

class _ViewJobState extends State<ViewJob> {
  late Future<Job> futureJob;

  @override
  void initState() {
    super.initState();
    futureJob = JobService().getJobById(widget.jobId); // Fetch the job details by ID
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
        title: const Text('Job Details'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Job>(
        future: futureJob,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No job found'));
          }

          final job = snapshot.data!;
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
                        job.jobTitle,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Job Type label with color
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: _getJobTypeColor(job.jobTypeEnum),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          job.jobTypeEnum,
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
                        job.jobDescription,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Document Download Button
                if (job.documentUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          downloadFile(
                            'https://example.com${job.documentUrl!}', // Replace with the correct base URL
                            job.documentUrl!.split('/').last,
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

  // Helper method to get the corresponding color for the job type
  Color _getJobTypeColor(String jobType) {
    switch (jobType) {
      case 'Full-time':
        return Colors.green;
      case 'Part-time':
        return Colors.orange;
      case 'Contract':
        return Colors.blue;
      default:
        return Colors.grey; // Default color for unknown job type
    }
  }
}
